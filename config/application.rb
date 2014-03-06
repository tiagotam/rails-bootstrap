require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module RailsBootstrap
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    #config.time_zone = 'Brasilia'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.enforce_available_locales = false
    config.i18n.default_locale = 'pt'

    # Precompile config
    config.assets.precompile += [/ie_lt8.js$/, /ie_lt9.js$/, /ie_lt7.css$/, /ie_lt8.css$/]
    config.assets.precompile +=  %w(*.png *.jpg *.jpeg *.gif *.eot *.svg *.ttf *.woff .oft)

    # Number of records per page
    WillPaginate.per_page = 20

    # Configure layout template for emails sent by application
    config.to_prepare do
      Devise::Mailer.layout "email"
      Devise::SessionsController.layout "site"
      Devise::RegistrationsController.layout  proc{ |controller| user_signed_in? ? "application"   : "site" }
      Devise::ConfirmationsController.layout "site"
      Devise::UnlocksController.layout "site"
      Devise::PasswordsController.layout "site"

    end




  end
end
