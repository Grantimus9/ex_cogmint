defmodule ExCogmint.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: ExCogmint.Worker.start_link(arg)
      # {ExCogmint.Worker, arg},
      # Probably want to hold some auth info here.

      {ExCogmint.Config, []}
      # Can also add a retries genserver here.
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExCogmint.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
