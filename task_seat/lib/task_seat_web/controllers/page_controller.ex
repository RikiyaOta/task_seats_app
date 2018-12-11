defmodule TaskSeatWeb.PageController do
  use TaskSeatWeb, :controller

  def home(conn, _params) do
    render conn, "home.html"
  end
end
