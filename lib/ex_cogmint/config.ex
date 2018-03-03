defmodule ExCogmint.Config do
  use GenServer
  require Logger

  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    apikey = get_api_key_from_env()
    state = Map.put(state, :apikey, apikey)
    {:ok, state}
  end

  def api_key() do
    GenServer.call(__MODULE__, :api_key)
  end

  # SERVER
  def handle_call(:api_key, _from, state) do
    api_key = Map.get(state, :apikey)
    {:reply, api_key, state}
  end

  def get_api_key_from_env() do
    case Application.get_env(:ex_cogmint, :cogmint_api_key) do
      nil ->
        case System.get_env("COGMINT_API_KEY") do
          nil ->
            Logger.warn("Cogmint Initialization error: No API key. Please set :ex_cogmint, cogmint_api_key: 'cogmint_api_key_here' in your app's config.exs file.")
            nil

          key ->
            Logger.warn("Using ENV COGMINT_API_KEY value, we recommend instead setting :ex_cogmint, cogmint_api_key: 'cogmint_api_key_here' in your app's config.exs file.")
            key
        end

      key ->
        key
    end
  end


end
