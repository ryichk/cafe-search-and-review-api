require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cafeshares
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.assets.paths << "#{Rails}/vendor/assets/fonts"
    config.load_defaults 5.1
    config.i18n.default_locale = :ja
    config.secret_key_base = '<%= ENV["SECRET_KEY_BASE"] %>'
    config.assets.initialize_on_precompile = false
    config.generators do |g|
      g.test_framework :rspec,
                       view_specs: false,
                       helper_specs: false,
                       controller_specs: false,
                       routing_specs: false,
                       request_specs: false
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
