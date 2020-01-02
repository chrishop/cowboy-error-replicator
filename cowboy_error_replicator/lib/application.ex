defmodule CowboyErrorReplicator.Application do
  @moduledoc """
  Documentation for CowboyErrorReplicator.Application
  """

  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: CowboyErrorReplicator.Endpoint,
        options: [port: 4001]
      )
    ]

    opts = [strategy: :one_for_one, name: CowboyErrorReplicator.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
