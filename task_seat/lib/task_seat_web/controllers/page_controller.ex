defmodule TaskSeatWeb.PageController do
  use TaskSeatWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
