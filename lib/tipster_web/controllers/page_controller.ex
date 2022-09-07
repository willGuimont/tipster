defmodule TipsterWeb.PageController do
  use TipsterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
