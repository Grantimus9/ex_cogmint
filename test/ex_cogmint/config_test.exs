defmodule ExCogmint.ConfigTest do
  use ExUnit.Case, async: true

  setup do
    Application.put_env(:ex_cogmint, :cogmint_api_key, "test-apikey")
    Application.put_env(:ex_cogmint, :callback_url, "https://localhost:4000/incomingwebhooks")
    ExCogmint.Config.start_link([])
    {:ok, %{}}
  end

  test "Returns api_key" do
    key = ExCogmint.Config.api_key()
    assert is_binary(key)
    refute is_nil(key)
  end

  test "Returns server_url" do
    url = ExCogmint.Config.server_url()
    assert is_binary(url)
    refute is_nil(url)
  end

  test "Returns callback_url" do
    url = ExCogmint.Config.callback_url()
    assert is_binary(url)
    refute is_nil(url)
  end

end
