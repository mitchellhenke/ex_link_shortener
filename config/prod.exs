use Mix.Config
port = System.get_env("PORT") |> String.to_integer

config :link_shortener,
  http: [port: port]
