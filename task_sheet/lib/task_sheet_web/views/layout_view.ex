defmodule TaskSheetWeb.LayoutView do
  use TaskSheetWeb, :view

  alias TaskSheet.Accounts.Auth.Guardian

  def is_logged_in?(conn) do
    Guardian.Plug.authenticated?(conn)
  end

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

end
