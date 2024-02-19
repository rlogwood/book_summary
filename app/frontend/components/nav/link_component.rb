# frozen_string_literal: true

class Nav::LinkComponent < ViewComponent::Base
  INACTIVE_STYLE = "hover:bg-gray-100 hover:text-blue-600 rounded-md px-3 py-2 text-md font-medium" #.freeze
  ACTIVE_STYLE = "bg-yellow-200  text-amber-900 rounded-md px-3 py-2 text-md font-medium" #.freeze

  attr_reader :text, :path, :style, :attributes

  def self.link_styles
    "#{ACTIVE_STYLE} #{INACTIVE_STYLE}".split(' ').uniq.sort.join(' ')
  end

  def initialize(text:, path:, inactive_style: nil, active_style: nil, **attributes)
    super()
    @text = text
    @path = path
    @attributes = attributes || {}

    @inactive = inactive_style || DEFAULT_STYLE
    active_style ||= ACTIVE_STYLE
    @active = active_style
  end

  def before_render
    page_is_current = current_page?(path)
    @style = page_is_current ? @active : @inactive
    puts "page_is_current: #{page_is_current}, path: #{path}, style: #{@style}"
  end

end

