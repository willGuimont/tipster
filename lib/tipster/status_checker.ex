defmodule Tipster.StatusChecker do
  use GenServer

  alias Tipster.Endpoints
  alias Tipster.Ping

  @period 5000

  def start_link(_supervisor, arg) do
    GenServer.start_link(Tipster.StatusChecker, arg)
  end

  @impl true
  def init(arg) do
    Process.send_after(self(), :poll, @period)
    {:ok, arg}
  end

  @impl true
  def handle_info(:poll, state = %{endpoint_id: endpoint_id}) do
    endpoint = Endpoints.get_endpoint(endpoint_id)
    status = get_status(endpoint.url)

    ping = %Ping{status: String.capitalize(Atom.to_string(status))}
    Endpoints.add_ping(endpoint, ping)

    TipsterWeb.Endpoint.broadcast("endpoint:#{endpoint.id}", "update", endpoint)

    Process.send_after(self(), :poll, @period)
    {:noreply, state}
  end

  defp get_status(url) do
    case HTTPoison.get(url) do
      {:ok, response} -> if response.status_code == 200, do: :operational, else: :down
      {:error, _} -> :down
    end
  end
end
