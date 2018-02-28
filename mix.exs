defmodule ExCogmint.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_cogmint,
      version: "0.0.1",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package(),
      description: "Client for Cogmint Project"
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
      {:ex_doc, ">= 0.0.0", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
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
