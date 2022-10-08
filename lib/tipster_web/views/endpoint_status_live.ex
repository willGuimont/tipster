defmodule TipsterWeb.EndpointStatusLive do
  use TipsterWeb, :live_view

  alias Tipster.Endpoints

  @impl true
  def render(assigns) do
    ~H"""
    <span>Status: </span>
    <%= if @has_ping do %>
      <span><%= @last_ping.status %> <%= if @last_ping.status == "Operational", do: "🟢", else: "🔴" %></span>
    <% else %>
      <span>Unknown ❓</span>
    <% end %>
    """
  end

  @impl true
  def mount(_params, %{"endpoint_id" => endpoint_id}, socket) do
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
    endpoint_id = endpoint.id
    has_ping = length(endpoint.pings) > 0
    last_ping = List.last(endpoint.pings)

    socket
    |> assign(:endpoint_id, endpoint_id)
    |> assign(:endpoint, endpoint)
    |> assign(:has_ping, has_ping)
    |> assign(:last_ping, last_ping)
  end
end
