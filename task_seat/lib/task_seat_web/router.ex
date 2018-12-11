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

  scope "/", TaskSeatWeb, [as: :task_seat] do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :home

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    post "/logout", SessionController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", TaskSeatWeb do
  #   pipe_through :api
  # end
end
