defmodule TaskSeatWeb.SessionController do
  use TaskSeatWeb, :controller

  alias TaskSeat.Accounts
  alias TaskSeat.Accounts.User
  alias TaskSeat.Accounts.User.Guardian
  alias TaskSeat.Accounts.User.Auth

  def new(conn, _opts) do
    changeset = Accounts.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)
    if maybe_user do
      conn
      |> redirect(to: task_seat_page_path(conn, :home))
    else
      conn
      |> assign(:changeset, changeset)
      |> assign(:action, task_seat_session_path(conn, :login))
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
    |> redirect(to: task_seat_session_path(conn, :login))
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:info, "ログインしました。")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: task_seat_page_path(conn, :home))
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> redirect(to: task_seat_session_path(conn, :new))
  end

end
