defmodule LinkShortener do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(__MODULE__, [], function: :run),
      supervisor(ConCache, [[
          ttl: 0
        ],
        [name: :link_cache]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LinkShortener.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    port = System.get_env("PORT")
    |> get_port

    {:ok, _} = Plug.Adapters.Cowboy2.http(LinkShortener.Router, [], [port: port])
  end

  defp get_port(nil), do: 4000
  defp get_port(port) when is_binary(port), do: String.to_integer(port)
end
