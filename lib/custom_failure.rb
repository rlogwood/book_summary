# frozen_string_literal: true

# Customize devise authentication needed prompt/flash
class CustomFailure < Devise::FailureApp
  def redirect_url
    super.tap do
      flash[:alert] = 'You need to sign in or sign up before continuing.'
    end
  end
end