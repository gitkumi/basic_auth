defmodule BasicAuthWeb.UserRegistrationControllerTest do
  use BasicAuthWeb.ConnCase, async: true

  import BasicAuth.AccountsFixtures

  alias BasicAuth.Guardian

  setup %{conn: conn} do
    user = user_fixture()

    {:ok, token, _claims} = Guardian.encode_and_sign(user)

    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "Bearer #{token}")

    {:ok, conn: conn}
  end

  test "should register user", %{conn: conn} do
    payload = %{
      "user" => %{
        "email" => "new@test.com",
        "password" => "not secure password",
        "first_name" => "Test",
        "last_name" => "Test"
      }
    }

    conn = post(conn, ~p"/api/users/register", payload)
    assert json_response(conn, 201)
  end

  test "should not register user when it exist", %{conn: conn} do
    user = user_fixture()

    payload = %{
      "user" => %{
        "email" => user.email,
        "password" => "not secure password",
        "first_name" => "Test",
        "last_name" => "Test"
      }
    }

    conn = post(conn, ~p"/api/users/register", payload)
    assert json_response(conn, 400)
  end
end
