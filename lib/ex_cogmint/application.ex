defmodule ExCogmint.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do

    case check_environment_variables() do
      :ok ->
        cogmint_key = Application.get_env(:ex_cogmint, "cogmint_api_key")
        IO.inspect cogmint_key
        nil
      error -> IO.puts "Cogmint Initialization error: \n" <> error
    end

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: ExCogmint.Worker.start_link(arg)
      # {ExCogmint.Worker, arg},

    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExCogmint.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def check_environment_variables() do
    :ok
  end
end
