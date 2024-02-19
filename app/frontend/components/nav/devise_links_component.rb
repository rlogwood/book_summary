# frozen_string_literal: true

class Nav::DeviseLinksComponent < ViewComponent::Base
  def initialize(login_text:, logout_text:, edit_text:, style:, as_list_elements:)
    super()
    @login_text = login_text
    @logout_text = logout_text
    @edit_text = edit_text
    @style = style
    @as_list_elements = as_list_elements
    Rails.logger.debug("as_list_elements:(#{@as_list_elements})")
  end

end
