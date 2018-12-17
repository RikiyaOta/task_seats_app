defmodule TaskSeatWeb.PageController do
  use TaskSeatWeb, :controller

  alias TaskSeat.Accounts.User.Guardian
  alias TaskSeat.Tasks

  def home(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    if is_nil(current_user) do
      conn
      |> assign(:current_user, nil)
      |> render("home.html")
    else
      sheats_of_current_user = Tasks.get_sheats_of_user(current_user)
      conn
      |> assign(:conn, conn)
      |> assign(:current_user, current_user)
      |> assign(:sheats, sheats_of_current_user)
      |> render("home.html")
    end
  end

end
