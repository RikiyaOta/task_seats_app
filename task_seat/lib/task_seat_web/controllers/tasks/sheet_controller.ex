defmodule TaskSeatWeb.Tasks.SheatController do
  use TaskSeatWeb, :controller

  alias TaskSeat.Tasks

  def show(conn, %{"sheat_id" => id}) do
    sheat = Tasks.get_sheat_with_tasks(id)
    conn
    |> assign(:conn, conn)
    |> assign(:sheat, sheat)
    |> render("show.html")
  end

end