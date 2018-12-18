defmodule TaskSheetWeb.SessionController do
  use TaskSheetWeb, :controller

  alias TaskSheet.Accounts
  alias TaskSheet.Accounts.User
  alias TaskSheet.Accounts.Auth.Guardian
  alias TaskSheet.Accounts.User.Auth

  require Logger

  def new(conn, _opts) do
    changeset = Accounts.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)
    if maybe_user do
      conn
      |> redirect(to: task_sheet_page_path(conn, :home))
    else
      conn
      |> assign(:changeset, changeset)
      |> assign(:action, task_sheet_session_path(conn, :login))
      |> render("new.html")
    end
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    Auth.authenticate_user(email, password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: task_sheet_session_path(conn, :login))
  end

  defp login_reply({:ok, user}, conn) do
    Logger.info "###SessionController.login_reply###"
    Logger.info "user"
    Logger.info inspect(user)
    conn
    |> put_flash(:info, "ログインしました。")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: task_sheet_page_path(conn, :home))
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> redirect(to: task_sheet_session_path(conn, :new))
  end

end
