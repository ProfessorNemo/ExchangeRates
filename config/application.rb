# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ExchangeRates
  class Application < Rails::Application
    config.parent_controller = 'TurboController'
    config.navigational_formats = ['*/*', :html, :turbo_stream]

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.time_zone = 'Moscow'
    config.i18n.default_locale = :ru
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.active_job.queue_adapter = :sidekiq

  end
end
