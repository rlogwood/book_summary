# frozen_string_literal: true

# Manage main UI, use turbo stream to update summarizer results
class BookSummaryController < ApplicationController
  # TODO: make prompts changeable, use a choice list to manage prompts created by a scaffold
  COACH_SIMPLIFIED_PROMPT = <<-PROMPT
  I want you to act as a Life Coach. Please summarize the following non-fiction book,
  simplify the core principals in a way a child would be able to understand.
  Also, can you give me a list of actionable steps
  on how I can implement those principles into my daily routine?
  Return the response as HTML.
  PROMPT

  # entry point, show ui
  def request_summary; end

  # call back for summarize button
  def summarize
    return unless initialize_summary

    # use ruby-openai to get summary, block will manage the chunking
    helpers.summarize_book_with_ai(COACH_SIMPLIFIED_PROMPT, @book_title, @chatgpt_model.name,
                                   @temperature) do |chunk, _bytesize|
      delta = chunk.dig('choices', 0, 'delta', 'content') || ''
      @summary += delta
      update_summary_stream
    end

    # TODO: save summaries to DB for later retrieval and sharing

  rescue StandardError => e
    @summary = e.message
  end

  private

  # extract and validate parameters, initialize UI 
  def initialize_summary
    @messages = []
    @summary = ''

    extract_params
    return false unless validate_book_params

    # initialize the UI and continue to update it while summary is created
    update_summary_stream
    true
  end

  # update UI with current value of chucking or finalized summary
  def update_summary_stream
    # TODO: switch from global stream to session based stream, add devise user managment
    Turbo::StreamsChannel.broadcast_replace_to('book_summarizer',
                                               target: 'summary', partial: 'book_summary/book_summary',
                                               locals: {book_summary: @summary, model: @chatgpt_model,
                                                        temperature: @temperature })
  end

  # pull out user parameters
  def extract_params
    @book_title, @model_id, @temperature = params[:book].values_at(:title, :model, :temp)
    @chatgpt_model = ChatGptModel.find(@model_id)
    @temperature = @temperature.to_i

    Rails.logger.debug "book_title:#{@book_title}  model:#{@chatgpt_model.name}, #{@temperature}"
  end

  # check for valid params and update UI to show errors if any found
  def validate_book_params
    if @book_title.blank?
      Rails.logger.error('ERROR: Book title is blank!')
      @messages = ['Book title cannot be blank, please type in a book title you want summarized']
      update_summary_stream

      Turbo::StreamsChannel.broadcast_replace_to('book_summarizer',
                                                 target: 'summary',
                                                 partial: 'book_summary/params_error',
                                                 locals: {messages: @messages})

      return false # parameters are invalid
    end

    true
  end

end
