require 'securerandom'
module ApplicationHelper
  def session_turbo_stream_id
    unless session.has_key?(:turbo_stream_session)
      session[:turbo_stream_session] = SecureRandom.uuid
    end

    session[:turbo_stream_session]
  end
end
