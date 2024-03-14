# frozen_string_literal: true

# module RubyOpenAi
# This is a utility defining module functions to summarize a book
# and get the status of the rate limits using the ruby-openai gem
# @see https://github.com/alexrudall/ruby-openai
module RubyOpenAi
  module BookSummarizer
    module_function

    # This method is using the OpenAI's ruby-openai gem to retrieve a
    # book summary from ChatGpt
    #
    # @param prompt [String] The prompt to initialize the conversation with the model
    # @param book_title [String] The title of the book to summarize
    # @param model [String] The id of the model to use for the conversation
    # @param temperature [Float] Controls the randomness of the model's responses
    # @yieldparam The block that will receive and process the API's responses
    # @raise RubyOpenAiError when an exception occurs
    def book_summary(prompt:, book_title:, model:, temperature:, &chunker)
      client = OpenAI::Client.new  # NOTE: API token set in initializer

      messages = [
        { role: 'system', content: prompt },
        { role: 'user', content: book_title }
      ]

      Rails.logger.debug("Preparing to fetch summary for book: #{book_title}")
      Rails.logger.debug("messages: #{messages.inspect}")

      client.chat(
        parameters: {
          model:,
          messages:,
          temperature:,
          stream: chunker
        }
      )
    rescue StandardError => e
      raise RubyOpenAiError, "Book summary for #{book_title} failed with OpenAI error: #{e.message}"
    end
  end

  # This method is intended to handle the extraction of rate limit information
  # from an OpenAI response.
  #
  # @param response [Object] The response object from the OpenAI call.
  def rate_limits_status(response)
    raise NotImplementedError
  end

end
