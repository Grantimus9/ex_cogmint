defmodule ExCogmint.Client do
  @moduledoc """

  """
  def request!(%{path: path, body: body, method: method}) do
    full_url = build_full_url(path)
    body = build_body(body)
    headers = build_headers()

    HTTPoison.request(method, full_url, body, headers)
  end

  def build_full_url(path) do
    "http://localhost:4000" <> path
  end

  def build_headers() do
    apikey = ExCogmint.Config.api_key()
    ["apikey": apikey, "Accept": "Application/json; Charset=utf-8"]
  end

  def build_body(body) do
    body
  end

end
