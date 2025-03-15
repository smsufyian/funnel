defmodule Funnel.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FunnelWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:funnel, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Funnel.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Funnel.Finch},
      # Start a worker by calling: Funnel.Worker.start_link(arg)
      # {Funnel.Worker, arg},
      # Start to serve requests, typically the last entry
      FunnelWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Funnel.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FunnelWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
