defmodule Tipster.Repo do
  use Ecto.Repo,
    otp_app: :tipster,
    adapter: Ecto.Adapters.Postgres
end
