defmodule TaskSeatWeb.LayoutView do
  use TaskSeatWeb, :view

  alias TaskSeat.Accounts.User.Guardian

  def is_logged_in?(conn) do
    Guardian.Plug.authenticated?(conn)
  end

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

end
