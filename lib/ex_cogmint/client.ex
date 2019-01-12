defmodule ExCogmint.Client do
  @moduledoc """

  """
  alias ExCogmint.Config

  def request!(%{path: path, body: body, method: method}) do
    full_url = build_full_url(path)
    body = build_body(body)
    headers = build_headers()

    case HTTPoison.request(method, full_url, body, headers) do
      {:ok, response} ->
        handle_response(response)

      {:error, error} ->
        handle_error(error)
    end
  end

  def build_full_url(path) do
    Config.server_url() <> path
  end

  def build_headers() do
    apikey = ExCogmint.Config.api_key()
    [apikey: apikey, "Content-Type": "Application/json"]
  end

  def build_body(body) do
    body
  end

  def handle_error(error) do
    error
  end

  @doc """
    Handling bad HTTP responses needs to happen here.
  """
  def handle_response(%HTTPoison.Response{status_code: status_code}) when status_code >= 500 do
    {:error, "Cogmint Server Failure. (#{status_code})"}
  end

  def handle_response(response) do
    {:ok, decoded_body} = response.body |> Jason.decode()

    case Map.has_key?(decoded_body, "data") do
      true ->
        {:ok, decoded_body["data"]}

      false ->
        case Map.has_key?(decoded_body, "errors") do
          true ->
            {:error, decoded_body["errors"]}

          _ ->
            {:error, "Malformed Response From Cogmint Server"}
        end
    end
  end
end
