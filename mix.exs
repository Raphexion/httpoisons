defmodule Httpoisons.MixProject do
  use Mix.Project

  def project do
    [
      app: :httpoisons,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Httpoisons.Application, []}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.5"}
    ]
  end
end
