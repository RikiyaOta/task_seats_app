defmodule TaskSheet.Accounts.User.ErrorHandler do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)

    #テキストで表示されるの味気ない
    #conn
    #|> put_resp_content_type("text/plain")
    #|> send_resp(401, body)

    conn
    |> put_flash(:error, "ログインしてください")
    |> redirect(to: TaskSheetWeb.Router.Helpers.task_sheet_session_path(conn, :new))
  end

end
