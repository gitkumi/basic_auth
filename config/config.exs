# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :basic_auth,
  ecto_repos: [BasicAuth.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :basic_auth, BasicAuthWeb.Endpoint,
  adapter: Bandit.PhoenixAdapter,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: BasicAuthWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: BasicAuth.PubSub,
  live_view: [signing_salt: "4GiiOayF"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :basic_auth, BasicAuth.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :basic_auth, BasicAuth.Guardian,
  issuer: "basic_auth",
  secret_key: "n5n7bZTH9I6SVX6Fh5XAwbSgC0eYTj+1ti6rc7XfZRdIec2UpcKv7NucOnGrCv1A"

config :basic_auth, BasicAuth.AuthAccessPipeline,
  module: BasicAuth.Guardian,
  error_handler: BasicAuth.AuthErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
