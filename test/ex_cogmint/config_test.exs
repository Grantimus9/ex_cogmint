defmodule ExCogmint.ConfigTest do
  use ExUnit.Case, async: true

  setup do
    Application.put_env(:ex_cogmint, "cogmint_api_key", "test-apikey")
    ExCogmint.Config.start_link([])
    {:ok, %{}}
  end

  test "Returns api_key" do
    assert "test-apikey" == ExCogmint.Config.api_key()
  end

  



end
