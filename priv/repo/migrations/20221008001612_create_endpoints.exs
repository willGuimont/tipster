defmodule Tipster.Repo.Migrations.CreateEndpoints do
  use Ecto.Migration

  def change do
    create table(:endpoints) do
      add :name, :string
      add :url, :string
    end
  end
end
