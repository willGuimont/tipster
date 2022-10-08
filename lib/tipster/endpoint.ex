defmodule Tipster.Endpoint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "endpoints" do
    field :name, :string
    field :url, :string
  end

  def changeset(item, params) do
    item
    |> cast(params, [:name, :url])
    |> validate_required([:name, :url])
    |> validate_length(:name, min: 1)
    |> validate_length(:url, min: 1)
  end
end
