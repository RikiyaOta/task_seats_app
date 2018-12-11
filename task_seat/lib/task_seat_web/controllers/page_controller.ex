defmodule TaskSeatWeb.PageController do
  use TaskSeatWeb, :controller

  alias TaskSeat.Accounts.User.Guardian

  def home(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    conn
    |> assign(:conn, conn)
    |> assign(:current_user, current_user)
    |> render("home.html")
  end

end
