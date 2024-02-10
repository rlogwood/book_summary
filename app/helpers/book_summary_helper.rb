# frozen_string_literal: true

# manage OpenAI calls for summarizing book
module BookSummaryHelper

  # TODO: Figure out how to get a response from OpenAI::Client that includes rate limit status
  def rate_limits_status(response)
      # x-ratelimit-limit-requests	60	The maximum number of requests that are permitted before exhausting the rate limit.
      # x-ratelimit-limit-tokens	150000	The maximum number of tokens that are permitted before exhausting the rate limit.
      # x-ratelimit-remaining-requests	59	The remaining number of requests that are permitted before exhausting the rate limit.
      # x-ratelimit-remaining-tokens	149984	The remaining number of tokens that are permitted before exhausting the rate limit.
      # x-ratelimit-reset-requests	1s	The time until the rate limit (based on requests) resets to its initial state.
      # x-ratelimit-reset-tokens	6m0s	The time until the rate limit (based on tokens) resets to its initial state.
  end

  def summarize_book_with_ai(prompt, book_title, model_name, temperature, &chunker)
    Rails.logger.debug("openapi_key: #{openapi_key}")

    client = OpenAI::Client.new(access_token: openapi_key)
    summary = ''
    response = client.chat(
      parameters: {
        model: model_name, # Required.
        messages: [
          { role: 'system', content: prompt },
          { role: 'user', content: @book_title }], # Required.
        temperature:,
        stream: chunker
      })
    rate_limits_status(response)
    summary
  rescue StandardError => e
    raise "Book summary for #{book_title} failed with OpenAI error: #{e.message}"
  end

  private

  def openapi_key
    ENV.key?('openai_api_key') ? ENV['openai_api_key'] : Rails.application.credentials.openai_api_key
  end
end
