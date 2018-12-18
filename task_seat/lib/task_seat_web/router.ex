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

    get "/login",  SessionController, :new
    post "/login", SessionController, :login

    get "/users/new",     UserController, :new
    post "/users/create", UserController, :create
  end

  scope "/", TaskSeatWeb, [as: :task_seat] do
    pipe_through [:browser, :auth, :ensure_auth]
    post "/logout", SessionController, :logout
  end

  scope "/tasks", TaskSeatWeb.Tasks, [as: :task_seat_tasks] do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/sheat/show/:sheat_id",   SheatController, :show

    get "/task/new/:sheat_id",     TaskController,  :new
    post "/task/create/:sheat_id", TaskController,  :create

    get "/task/show/:task_id",     TaskController,  :show
    get "/task/new/:sheat_id",     TaskController,  :new
    post "/task/create/:sheat_id", TaskController,  :create
    get "/task/edit/:task_id",     TaskController,  :edit
    put "/task/update/:task_id",  TaskController,  :update
  end

  # Other scopes may use custom stacks.
  # scope "/api", TaskSeatWeb do
  #   pipe_through :api
  # end
end
