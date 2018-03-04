defmodule ExCogmintTest do
  use ExUnit.Case
  doctest ExCogmint

  test "add_task!/1 fails when inputs are nil or empty" do
    assert {:error, _} = ExCogmint.add_task!(nil, %{})
    assert {:error, _} = ExCogmint.add_task!("uuid", nil)
    assert {:error, _} = ExCogmint.add_task!("uuid", %{})
  end

  test "add_task/1 returns error tuple when project doesn't exist" do
    assert {:error, reason} = ExCogmint.add_task!("not-real-uuid", %{variable: "some-value"})
    assert Regex.match?(~r/No Project Matches/, reason)
  end

  

end
