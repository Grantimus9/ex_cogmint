defmodule ExCogmint.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_cogmint,
      version: "0.0.5",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: "Elixir Client for Cogmint.com"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExCogmint.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.19.0", only: :dev},
      {:httpoison, "~> 1.0"},
      {:jason, "~> 1.0"}
    ]
  end

  defp package() do
    [
      maintainers: ["Grant Nelson"],
      licenses: ["None"],
      links: %{"Site" => "https://www.cogmint.com"}
    ]
  end
end
