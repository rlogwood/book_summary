# frozen_string_literal: true

class NavLinkComponentPreview < ViewComponent::Preview
  def default
    render(NavLinkComponent.new(text: "text", path: "path", inactive_style: "inactive_style", active_style: "active_style"))
  end
end
