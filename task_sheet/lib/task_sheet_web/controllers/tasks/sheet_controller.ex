defmodule TaskSheetWeb.Tasks.SheetController do
  use TaskSheetWeb, :controller

  alias TaskSheet.Tasks

  def show(conn, %{"sheet_id" => id}) do
    sheet = Tasks.get_sheet_with_tasks(id)
    conn
    |> assign(:conn, conn)
    |> assign(:sheet, sheet)
    |> render("show.html")
  end

end
