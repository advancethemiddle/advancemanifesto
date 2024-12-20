require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AdvanceManifesto
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.action_mailer.default_options = { from: "Sunjay Armstead <no-reply@advancemanifesto.com>", bcc: "connect@sunjayarmstead.com" }

    config.action_mailer.smtp_settings = {
      user_name: ENV["SMTP_USERNAME"],
      password: ENV["SMTP_PASSWORD"],
      port: ENV["SMTP_PORT"],
      domain: ENV["SMTP_DOMAIN"],
      address: ENV["SMTP_ADDRESS"],
      authentication: :plain,
      enable_starttls_auto: true
    }

    config.active_job.queue_adapter = :sidekiq

    # Opt in to Rails 8.1 `to_time` behavior (preserves full timezone rather than offset of the receiver)
    # https://api.rubyonrails.org/classes/Time.html#method-i-to_time
    config.active_support.to_time_preserves_timezone = :zone
  end
end
