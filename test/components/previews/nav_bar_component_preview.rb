# frozen_string_literal: true

class NavBarComponentPreview < ViewComponent::Preview
  def default
    render(NavBarComponent.new(links: "links", show_devise: "show_devise", inactive_style: "inactive_style", active_style: "active_style"))
  end
end
