defmodule Tipster.Endpoints do
  alias Tipster.Endpoint
  alias Tipster.Repo
  import Ecto.Query

  def get_endpoint(id) do
    Repo.get(Endpoint, id)
  end

  def list_endpoints() do
    query = Endpoint |> order_by(desc: :id)
    Repo.all(query)
  end

  def delete_endpoint(id) do
    endpoint = Repo.get(Endpoint, id)
    Repo.delete(endpoint)
  end

  def create_endpoint(name, url) do
    %Endpoint{}
    |> Endpoint.changeset(%{name: name, url: url})
    |> Repo.insert()
  end
end
