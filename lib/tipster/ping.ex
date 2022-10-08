defmodule Tipster.Ping do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pings" do
    field :status, :string
    field :timestamp, :utc_datetime
    belongs_to :endpoint, Tipster.Endpoint
  end

  def changeset(item, params) do
    item
    |> cast(params, [:name, :url])
  end
end
