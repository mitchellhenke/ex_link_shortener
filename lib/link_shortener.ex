defmodule LinkShortener do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(__MODULE__, [], function: :run),
      worker(ConCache, [[
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
    cowboy_config = Application.get_env(:link_shortener, :http)
    {:ok, _} = Plug.Adapters.Cowboy.http(LinkShortener.Router, cowboy_config)
  end
end
