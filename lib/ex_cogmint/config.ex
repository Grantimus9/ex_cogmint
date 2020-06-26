defmodule ExCogmint.Config do
  @moduledoc """
    Configuration for the ExCogmint app.

    Provide configuration in your application's config.exs.

    Example configuration:
    ```
    config :ex_cogmint,
      cogmint_api_key: System.get_env("COGMINT_API_KEY"),
      callback_url: System.get_env("COGMINT_CALLBACK_URL"),
      cogmint_url: System.get_env("COGMINT_URL")
    ```

    cogmint_api_key: required. The API key for your Cogmint account.

    callback_url: optional. Sets the default callback_url on each task created. If your app has a single endpoint for receiving all callbacks from Cogmint it is recommended to set this, or else you
    need to set it individually on every task creation API call.

    cogmint_url: optional. The URL where this app expects to find Cogmint. You should never need to set this.
  """

  use GenServer
  require Logger

  @doc false
  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @doc false
  def init(state) do
    apikey = get_api_key_from_env()
    server_url = get_server_url()
    callback_url = get_callback_url()

    state =
      state
      |> Map.put(:apikey, apikey)
      |> Map.put(:server_url, server_url)
      |> Map.put(:callback_url, callback_url)

    {:ok, state}
  end

  @doc """
    Returns the API key.
  """
  def api_key() do
    GenServer.call(__MODULE__, :api_key)
  end

  @doc """
    Returns the Cogmint server URL. You should never need to change this, but
    can point this library at any endpoint you want, perhaps to test calls that are
    sent.
  """
  def server_url() do
    GenServer.call(__MODULE__, :server_url)
  end

  @doc """
    The default callback URL for tasks created via this API. Cogmint will send webhook
    events to this URL, such as "task_completed".
  """
  def callback_url() do
    GenServer.call(__MODULE__, :callback_url)
  end

  # SERVER
  @doc false
  def handle_call(:api_key, _from, state) do
    api_key = Map.get(state, :apikey)
    {:reply, api_key, state}
  end

  @doc false
  def handle_call(:server_url, _from, state) do
    server_url = Map.get(state, :server_url)
    {:reply, server_url, state}
  end

  @doc false
  def handle_call(:callback_url, _from, state) do
    callback_url = Map.get(state, :callback_url)
    {:reply, callback_url, state}
  end

  @doc false
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

  @doc """
    Retrieves cogmint_url from config or uses https://www.cogmint.com (default)
  """
  def get_server_url() do
    case Application.get_env(:ex_cogmint, :cogmint_url) do
      nil ->
        "https://www.cogmint.com"

      url ->
        url
    end
  end

  @doc """
    Retrieves the default callback (webhook) URL where Cogmint will send webhooks.
  """
  def get_callback_url() do
    Application.get_env(:ex_cogmint, :callback_url)
  end
end
