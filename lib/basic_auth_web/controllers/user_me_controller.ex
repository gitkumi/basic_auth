defmodule BasicAuthWeb.UserMeController do
  use BasicAuthWeb, :controller

  def show(conn, _opts) do
    user = conn.private.guardian_default_resource

    conn
    |> put_view(json: BasicAuthWeb.UserJSON)
    |> render(:show, %{user: user})
  end
end
