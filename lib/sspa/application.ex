defmodule Sspa.Application do
  use Application
  require Logger

    def start(_type, _args) do
      children = [
        #{Plug.Cowboy, scheme: :http, plug: Sspa.Plug, options: [port: cowboy_port()]}
        #{Plug.Cowboy, scheme: :http, plug: {Plug.Static, at: "/", from: "learnjs/public"}, options: [port: cowboy_port()]}
        {Plug.Cowboy, scheme: :http, plug: Sspa.Router, options: [port: cowboy_port()]}
      ]
      opts = [strategy: :one_for_one, name: Sspa.Supervisor]

      Logger.info("Starting Application...")

      Supervisor.start_link(children, opts)
  end

  defp cowboy_port, do: Application.get_env(:sspa, :cowboy_port, 8080)
end
