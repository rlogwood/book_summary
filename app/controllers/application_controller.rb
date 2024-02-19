class ApplicationController < ActionController::Base
  before_action :add_custom_view_path
  #before_action :authenticate_user!

  protected
  def add_custom_view_path
    prepend_view_path "app/frontend/components"
  end

  # def after_sign_in_path_for(resource)
  #   flash[:success] = 'Logged in successfully!'
  #   super(resource)
  # end
end
