defmodule BasicAuth.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BasicAuthWeb.Telemetry,
      # Start the Ecto repository
      BasicAuth.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: BasicAuth.PubSub},
      # Start Finch
      {Finch, name: BasicAuth.Finch},
      # Start the Endpoint (http/https)
      BasicAuthWeb.Endpoint
      # Start a worker by calling: BasicAuth.Worker.start_link(arg)
      # {BasicAuth.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BasicAuth.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BasicAuthWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
