defmodule BlueBook.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      BlueBook.Repo,
      # Start the Telemetry supervisor
      BlueBookWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BlueBook.PubSub},
      # Start the Endpoint (http/https)
      BlueBookWeb.Endpoint
      # Start a worker by calling: BlueBook.Worker.start_link(arg)
      # {BlueBook.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BlueBook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BlueBookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
