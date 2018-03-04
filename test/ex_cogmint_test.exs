defmodule ExCogmintTest do
  use ExUnit.Case
  doctest ExCogmint

  test "add_task!/1 fails when inputs are nil or empty" do
    assert {:error, _} = ExCogmint.add_task!(nil, %{})
    assert {:error, _} = ExCogmint.add_task!("uuid", nil)
    assert {:error, _} = ExCogmint.add_task!("uuid", %{})
  end
end
