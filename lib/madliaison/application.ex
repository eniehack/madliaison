defmodule Madliaison.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Madliaison.Router, options: [port: 8080]}
    ]
    opts = [strategy: :one_for_one, name: Madliaison.Supervisor]

    Logger.info("Starting application")

    Supervisor.start_link(children, opts)
  end
end
