defmodule BasicAuthWeb.UserLoginController do
  use BasicAuthWeb, :controller

  alias BasicAuth.Accounts
  alias BasicAuth.Guardian

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    if user = Accounts.get_user_by_email_and_password(email, password) do
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn
      |> put_view(json: BasicAuthWeb.UserJSON)
      |> render(:show, %{user: user, token: token})
    else
      conn
      |> put_status(:bad_request)
      |> json(%{
        data: %{
          error: "Invalid email or password."
        }
      })
    end
  end
end
