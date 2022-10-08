defmodule Tipster.StatusCheckerSupervisor do
  use DynamicSupervisor

  alias Tipster.Endpoints

  def start_link(init_arg) do
    out = {:ok, _} = DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)

    Endpoints.list_endpoints()
    |> Enum.each(fn e -> start_child(e) end)

    out
  end

  def start_child(endpoint) do
    spec = {Tipster.StatusChecker, %{endpoint_id: endpoint.id}}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  @impl true
  def init(init_arg) do
    DynamicSupervisor.init(
      strategy: :one_for_one,
      extra_arguments: [init_arg]
    )
  end
end
