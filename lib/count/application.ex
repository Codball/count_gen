defmodule Count.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    topologies = [
      counter_cluster: [
        strategy: Cluster.Strategy.Gossip
      ]
    ]

    children = [
      # Starts a worker by calling: Count.Worker.start_link(arg)
      {Cluster.Supervisor, [topologies, [name: Counter.ClusterSupervisor]]},
      {Count.Worker, nil}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Count.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
