defmodule Smg.MixProject do
  use Mix.Project

  def project do
    [
      app: :smg,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:httpoison, :table_rex],
      extra_applications: [:logger],
      mod: {Smg, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:ex_cli, "~> 0.1.0"},
      {:poison, "~> 3.1"},
      {:table_rex, "~> 0.10"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
