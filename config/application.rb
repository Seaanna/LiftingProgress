require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LiftingProgress
  class Application < Rails::Application
    # enabling state helpers
    config.react.addons = true

  end
end
