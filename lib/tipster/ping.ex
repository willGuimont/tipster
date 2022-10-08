defmodule Tipster.Ping do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pings" do
    field :status, :string
    belongs_to :endpoint, Tipster.Endpoint
    timestamps()
  end

  def changeset(item, params) do
    item
    |> cast(params, [:status])
    |> validate_required([:status])
  end
end
