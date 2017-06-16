# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :hiv_monitor, HivMonitor.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NJa8THn6ond8vJFSpkULFz176EpJDXFGgjDYiHE9PfWKAWNnxJC8AlnwKexegnPS",
  render_errors: [view: HivMonitor.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HivMonitor.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Start with selenium driver (default)
#config :hound, driver: "chrome_driver"
config :hound, driver: "phantomjs"


# Configures the MailGun setup
config :hiv_monitor, HivMonitor.Mailer,
  adapter: Bamboo.MailgunAdapter,
  api_key: "secret-key",
  domain: "mailgun-domain"