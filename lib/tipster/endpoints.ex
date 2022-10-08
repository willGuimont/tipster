defmodule Tipster.Endpoints do
  alias Tipster.Endpoint
  alias Tipster.Repo
  alias Tipster.StatusCheckerSupervisor

  import Ecto.Query

  def create_endpoint(params) do
    {:ok, endpoint} = %Endpoint{}
    |> Endpoint.changeset(params)
    |> Repo.insert()
    StatusCheckerSupervisor.start_child(endpoint)
  end

  def get_endpoint(id) do
    Repo.get(Endpoint, id) |> Repo.preload(:pings)
  end

  @spec list_endpoints :: nil | [%{optional(atom) => any}] | %{optional(atom) => any}
  def list_endpoints() do
    query = Endpoint |> order_by(desc: :id)
    Repo.all(query) |> Repo.preload(:pings)
  end

  def add_ping(endpoint, ping) do
    endpoint
    |> Ecto.Changeset.change(pings: [ping | endpoint.pings])
    |> Repo.update()
  end

  def delete_endpoint(id) do
    endpoint = Repo.get(Endpoint, id)
    Repo.delete(endpoint)
  end
end
