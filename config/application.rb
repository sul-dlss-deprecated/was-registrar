# frozen_string_literal: true

require File.expand_path('boot', __dir__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WasRegistrar
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.assets.enabled = true

    config.autoload_paths += %W[#{config.root}/lib]

    config.assets.paths << "#{Rails.root}/app/assets/fonts"
    config.assets.version = '1.0'

    # Enable the asset pipeline
    # Precompile additional assets
    config.assets.precompile += %w[*.png *.jpg *.jpeg *.gif *.eot *.svg *.ttf *.otf *.woff app/assets/stylesheets/**/* app/assets/fonts/*]
  end
end
