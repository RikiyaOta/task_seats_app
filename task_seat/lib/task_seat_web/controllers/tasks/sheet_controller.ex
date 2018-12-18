defmodule TaskSheetWeb.Tasks.SheatController do
  use TaskSheetWeb, :controller

  alias TaskSheet.Tasks

  def show(conn, %{"sheat_id" => id}) do
    sheat = Tasks.get_sheat_with_tasks(id)
    conn
    |> assign(:conn, conn)
    |> assign(:sheat, sheat)
    |> render("show.html")
  end

end
