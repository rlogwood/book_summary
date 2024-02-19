# Custom Tailwind CSS list of dynamic classes to safelist

# To allow loading of link_component, create fake ViewComponent::Base class and Nav module

module ViewComponent
  class Base
  end
end

module Nav
  puts "Current Directory: #{Dir.pwd}"
  require_relative "../../../../../../.config/JetBrains/RubyMine2023.3/scratches/nav/tend/link_component"
  safelist_file = "./config/tailwind_dynamic_classes.txt"
  puts "Creating tailwind css safelist file (#{safelist_file})..."

  File.open(safelist_file, "w") do |file|
    file.puts Nav::LinkComponent.link_styles.split().join("\n")
  end
end
