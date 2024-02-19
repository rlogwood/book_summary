# frozen_string_literal: true
require 'action_view'
require 'action_controller'

class Nav::BarComponent < ViewComponent::Base
  def initialize(links:, show_devise: false, inactive_style: nil, active_style: nil)
    super()

    @no_turbo = { turbo: false }
    @nav_links = []
    links.each do |link|
      @nav_links.push Nav::LinkComponent.new(text: link[:text], path: link[:path],
                                             inactive_style:, active_style:) # to disable turbo use: , data: @no_turbo

    end

    @show_devise = show_devise
    @devise_style = inactive_style
  end
end
