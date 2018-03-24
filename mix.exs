defmodule LinkShortener.Mixfile do
  use Mix.Project

  def project do
    [
      app: :link_shortener,
      version: "0.0.4",
      elixir: "~> 1.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [:runtime_tools, :logger, :cowboy, :plug, :con_cache],
      mod: {LinkShortener, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:cowboy, "~> 2.0"},
      {:plug, "~> 1.0"},
      {:con_cache, "~> 0.12.0"},
      {:distillery, "~> 1.5"}
    ]
  end
end
