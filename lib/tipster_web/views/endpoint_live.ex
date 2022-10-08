defmodule TipsterWeb.EndpointLive do
  use TipsterWeb, :live_view

  alias Tipster.Endpoints

  @impl true
  def render(assigns) do
    ~H"""
    <h2><%= @endpoint.name %></h2>
    <%= link @endpoint.url, to: @endpoint.url, target: "_blank", rel: "noopener noreferrer" %>
    <table>
      <tr>
        <th>Time</th>
        <th>Status</th>
      </tr>
      <%= for ping <- @chronological_pings do %>
        <tr>
          <td><%= ping.inserted_at %></td>
          <td>
            <span><%= ping.status %> <%= if ping.status == "Operational", do: "🟢", else: "🔴" %></span>
          </td>
        </tr>
      <% end %>
    </table>
    """
  end

  @impl true
  def mount(%{"endpoint_id" => endpoint_id}, _, socket) do
    if connected?(socket), do: TipsterWeb.Endpoint.subscribe("endpoint:#{endpoint_id}")
    endpoint = Endpoints.get_endpoint(endpoint_id)
    socket = update_socket(socket, endpoint)
    {:ok, socket}
  end

  @impl true
  def handle_info(%{event: "update", payload: endpoint}, socket) do
    socket = update_socket(socket, endpoint)
    {:noreply, socket}
  end

  defp update_socket(socket, endpoint) do
    chronological_pings = Enum.sort(endpoint.pings, :desc)

    socket
    |> assign(:endpoint, endpoint)
    |> assign(:chronological_pings, chronological_pings)
  end
end
