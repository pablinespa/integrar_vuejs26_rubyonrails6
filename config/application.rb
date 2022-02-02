require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IntegrarVuejs26Rubyonrails6
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.paths["config/routes.rb"].concat(Dir[Rails.root.join("config/routes/admin.rb")])
    config.paths["config/routes.rb"].concat(Dir[Rails.root.join("config/routes/api.rb")])
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    #
    config.paths.add Rails.root.join('app', 'validators').to_s, autoload: true
    config.paths.add Rails.root.join('app', 'serializers').to_s, autoload: true
  end
end
