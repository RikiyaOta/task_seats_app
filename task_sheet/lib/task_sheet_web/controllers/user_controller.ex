defmodule TaskSheetWeb.UserController do
  use TaskSheetWeb, :controller

  use Timex
  require Logger

  alias TaskSheet.Accounts
  alias TaskSheet.Accounts.User
  alias TaskSheet.Tasks.Sheet

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{}, %{})
    action = task_sheet_user_path(conn, :create)

    conn
    |> assign(:conn, conn)
    |> assign(:changeset, changeset)
    |> assign(:action, action)
    |> render("new.html")
  end

  #TODO
  #ユーザー作成したら、デフォルトのsheetだけは作っておく必要がある。
  def create(conn, %{"user" => %{"name" => name, "email" => email, "password" => password}}) do
    now = Timex.now
    system_account = Accounts.get_first_system_account()

    params_with_default_sheets = %{
      name: name,
      email: email,
      password: password,
      sheets: [
        %{
          name: "最初のタスクシート",
          created_at: now,
          created_by: system_account.id,
          modified_at: now,
          modified_by: system_account.id
        }
      ],
      created_at: now,
      created_by: system_account.id
    }

    case Accounts.create_user_with_associated_sheets(params_with_default_sheets) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "ユーザー登録作成完了しました。")
        |> redirect(to: task_sheet_session_path(conn, :new))
      {:error, %Ecto.Changeset{} = error} ->
        Logger.error inspect(error)
        conn
        |> put_flash(:info, "ユーザー登録作成に失敗しました。")
        |> assign(:conn, conn)
        |> assign(:changeset, error)
        |> assign(:action, task_sheet_user_path(conn, :new))
        |> render("new.html")
    end

  end

end
