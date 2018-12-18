defmodule TaskSheetWeb.PageController do
  use TaskSheetWeb, :controller

  alias TaskSheet.Accounts.Auth.Guardian
  alias TaskSheet.Tasks

  def home(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    if is_nil(current_user) do
      conn
      |> assign(:current_user, nil)
      |> render("home.html")
    else
      sheets_of_current_user = Tasks.get_sheets_of_user(current_user)
      conn
      |> assign(:conn, conn)
      |> assign(:current_user, current_user)
      |> assign(:sheets, sheets_of_current_user)
      |> render("home.html")
    end
  end

end
