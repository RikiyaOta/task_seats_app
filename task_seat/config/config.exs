# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :task_seat,
  ecto_repos: [TaskSeat.Repo]

# Configures the endpoint
config :task_seat, TaskSeatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LxOkv6nJpZYksonjO2S56afEt6SVPit6Q9i9cpjDYB2Q7kDcT4wBhfl/RwjUTfWJ",
  render_errors: [view: TaskSeatWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TaskSeat.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :task_seat, TaskSeat.Accounts.User.Guardian,
  issuer: "task_seat",
  secret_key: "z9r0C0bOX4r42oHrhwxewf8gmLvAWxfXkPzhOsNHCj9GQ7P9BEbxeYRtwMlv8//b"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
