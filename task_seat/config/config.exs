# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :task_sheet,
  ecto_repos: [TaskSheet.Repo]

# Configures the endpoint
config :task_sheet, TaskSheetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LxOkv6nJpZYksonjO2S56afEt6SVPit6Q9i9cpjDYB2Q7kDcT4wBhfl/RwjUTfWJ",
  render_errors: [view: TaskSheetWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TaskSheet.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :task_sheet, TaskSheet.Accounts.Auth.Guardian,
  issuer: "task_sheet",
  secret_key: "3e7TgOocOBokcfC8rQBewQikc0M1Taqv05sSB3LY8jmh4u+b45chzRrGChgWYR3Q"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
