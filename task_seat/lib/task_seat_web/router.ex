defmodule TaskSeatWeb.Router do
  use TaskSeatWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Our pipeline implements "maybe" authenticated. We'll use the `:ensure_auth` below for when we need to make sure someone is logged in.
  pipeline :auth do
    plug TaskSeat.Accounts.User.Pipeline
  end

  # We use ensure_auth to fail if there is no one logged in
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", TaskSeatWeb, [as: :task_seat] do
    pipe_through [:browser, :auth]

    get "/", PageController, :home

    get "/login", SessionController, :new
    post "/login", SessionController, :login
  end

  scope "/", TaskSeatWeb, [as: :task_seat] do
    pipe_through [:browser, :auth, :ensure_auth]
    post "/logout", SessionController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", TaskSeatWeb do
  #   pipe_through :api
  # end
end
