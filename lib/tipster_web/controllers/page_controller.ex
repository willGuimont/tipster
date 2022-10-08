defmodule TipsterWeb.PageController do
  use TipsterWeb, :controller

  alias Tipster.Endpoints
  alias Tipster.Endpoint

  def index(conn, _params) do
    endpoints = Endpoints.list_endpoints()
    changeset = Endpoint.changeset(%Endpoint{}, %{})
    render(conn, "index.html", endpoints: endpoints, changeset: changeset)
  end

  def create(conn, %{"endpoint" => endpoint_params}) do
    Endpoints.create_endpoint(endpoint_params)
    redirect(conn, to: "/endpoints")
  end
end
