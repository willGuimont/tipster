defmodule Tipster.Repo.Migrations.CreatePings do
  use Ecto.Migration

  def change do
    create table(:pings) do
      add :status, :string
      add :endpoint_id, references(:endpoints)
      timestamps(type: :utc_datetime)
    end
  end
end
