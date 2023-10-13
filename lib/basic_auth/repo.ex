defmodule BasicAuth.Repo do
  use Ecto.Repo,
    otp_app: :basic_auth,
    adapter: Ecto.Adapters.Postgres
end
