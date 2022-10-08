defmodule Tipster.Repo.Migrations.CreatePings do
  use Ecto.Migration

  def change do
    create table(:pings) do
      add :status, :string
      add :timestamp, :utc_datetime
      add :endpoint, references(:endpoints)
    end
  end
end
