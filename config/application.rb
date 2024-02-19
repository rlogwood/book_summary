require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BookSummary
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # NOTE: To get PropShaft to work with the view_component gem the following solution was followed:
    # https://github.com/rails/propshaft/issues/87#issuecomment-1127234248
    config.autoload_paths << Rails.root.join("app/frontend/components")
    config.importmap.cache_sweepers << Rails.root.join("app/frontend")
    config.assets.paths << Rails.root.join("app/frontend")
    config.view_component.view_component_path = "app/frontend/components"
  end
end
