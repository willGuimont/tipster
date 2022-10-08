defmodule Tipster.Endpoint do
  use Ecto.Schema
  alias Tipster.Ping
  import Ecto.Changeset

  schema "endpoints" do
    field :name, :string
    field :url, :string
    has_many :pings, Ping
  end

  def changeset(item, params) do
    item
    |> cast(params, [:name, :url])
    |> cast_assoc(:pings, with: &Ping.changeset/2)
    |> validate_required([:name, :url])
    |> validate_length(:name, min: 1)
    |> validate_length(:url, min: 1)
    |> unique_constraint(:name)
  end
end
