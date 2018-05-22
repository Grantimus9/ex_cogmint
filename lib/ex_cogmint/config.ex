defmodule ExCogmint.Config do
  use GenServer
  require Logger

  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    apikey = get_api_key_from_env()
    server_url = get_server_url()

    state =
      state
      |> Map.put(:apikey, apikey)
      |> Map.put(:server_url, server_url)

    {:ok, state}
  end

  def api_key() do
    GenServer.call(__MODULE__, :api_key)
  end

  def server_url() do
    GenServer.call(__MODULE__, :server_url)
  end

  # SERVER
  def handle_call(:api_key, _from, state) do
    api_key = Map.get(state, :apikey)
    {:reply, api_key, state}
  end

  def handle_call(:server_url, _from, state) do
    server_url = Map.get(state, :server_url)
    {:reply, server_url, state}
  end

  def get_api_key_from_env() do
    case Application.get_env(:ex_cogmint, :cogmint_api_key) do
      nil ->
        case System.get_env("COGMINT_API_KEY") do
          nil ->
            Logger.warn(
              "Cogmint Initialization error: No API key. Please set :ex_cogmint, cogmint_api_key: 'cogmint_api_key_here' in your app's config.exs file."
            )

            nil

          key ->
            Logger.warn(
              "Using ENV COGMINT_API_KEY value, we recommend instead setting :ex_cogmint, cogmint_api_key: 'cogmint_api_key_here' in your app's config.exs file."
            )

            key
        end

      key ->
        key
    end
  end

  def get_server_url() do
    case Application.get_env(:ex_cogmint, :cogmint_url) do
      nil ->
        "https://www.cogmint.com"
      url ->
        url
    end
  end
end
