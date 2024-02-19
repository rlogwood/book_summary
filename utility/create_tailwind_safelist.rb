# NOTE: this utility doesn't seem to be needed as of 2/18/24, the config/tailwind.config.js
# content setting appears to pick up all needed styles

# Create a file with a custom Tailwind CSS list of dynamic classes to safe list
# This file, if needed, can be included in the config/tailwind.config.js
# contents section as follows:
#
# module.exports = {
#   content: [
#     ...
#     './config/tailwind_dynamic_classes.txt'
#   ],

# To allow loading of link_component, create fake ViewComponent::Base class and Nav module
module ViewComponent
  class Base
  end
end

module Nav
  puts "Current Directory: #{Dir.pwd}"
  require_relative "../app/frontend/components/nav/link_component"
  safelist_file = "./config/tailwind_dynamic_classes.txt"
  puts "Creating tailwind css safelist file (#{safelist_file})..."

  File.open(safelist_file, "w") do |file|
    file.puts Nav::LinkComponent.link_styles.split().join("\n")
  end
end
