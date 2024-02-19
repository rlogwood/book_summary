# frozen_string_literal: true

# see https://dev.to/citronak/modern-rails-flash-messages-part-1-viewcomponent-stimulus-tailwind-css-3alm
# updated for current version of Turbo/Stimulus

class NotificationComponent < ViewComponent::Base
  # setting up font awesome can be a hassle, allow opt out
  USE_FONT_AWESOME = false

  def initialize(type:, data:)
    super()
    @use_fa = USE_FONT_AWESOME
    @type = type
    @data = prepare_data(data)
    @icon_class = icon_class
    @icon_color_class = icon_color_class

    @data[:timeout] ||= 3
    #puts("data[:countdown]=#{data[:countdown]}")
  end

  private

  def prepare_data(data)
    case data
    when Hash
      data
    else
      { title: data }
    end
  end


  def icon_class
    case @type
    when 'success'
      @use_fa ? 'fa-check-square' : '☑️'
    when 'error'
      @use_fa ? 'fa-exclamation-square' : '🚫'
    when 'alert'
      @use_fa ? 'fa-exclamation-square' : '⚠️' #'‼️'
    else
      @use_fa ? 'fa-info-square' : 'ℹ️'
    end
  end

  def icon_color_class
    case @type
    when 'success'
      'text-green-400'
    when 'error'
      'text-red-800'
    when 'alert'
      'text-red-400'
    else
      'text-gray-400'
    end
  end
end
