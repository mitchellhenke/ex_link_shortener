use Mix.Config

config :link_shortener,
  http: [port: {:system, "PORT"}]
