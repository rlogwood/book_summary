# frozen_string_literal: true

OpenAI.configure do |config|
  config.access_token =
    if ENV.key?('OPENAI_ACCESS_TOKEN')
      ENV['OPENAI_ACCESS_TOKEN']
    else
      Rails.application.credentials.openai_access_token
    end

  raise 'Missing env var OPENAI_ACCESS_TOKEN and key openai_access_token' if config.access_token.nil?
end
