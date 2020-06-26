defmodule ExCogmintTest do
  use ExUnit.Case
  doctest ExCogmint

  test "add_task!/1 fails when inputs are nil or empty" do
    assert {:error, _} = ExCogmint.add_task!(nil, %{})
    assert {:error, _} = ExCogmint.add_task!("uuid", nil)
    assert {:error, _} = ExCogmint.add_task!("uuid", %{})
  end

  test "add_task!/1 fails if not a valid API Key" do
    assert {:error, [%{"field" => "apikey"}]} = ExCogmint.add_task!("not-real-uuid", %{variable: "some-value"})
  end

  test "add_task! fails if passed a map with both string and atomic keys and a common key name" do
    assert {:error, _} = ExCogmint.add_task!("not-real-uuid", %{"collision" => "value", collision: "some other value"})
  end

  test "add_task! succeeds if given mixed keys for the substitutions map as long as there are no keyname collisions" do
    assert ExCogmint.add_task!("not-real-uuid", %{"no_collision" => "value", not_a_collision: "some other value"})
  end

  test "get_task!/1 fails if not sent a binary" do
    assert {:error, _msg} = ExCogmint.get_task!(123)
  end
  test "get_task!/1 fails if sent a task uuid thats too short" do
    assert {:error, _msg} = ExCogmint.get_task!("tooshort")
  end


  # get_project!/1
  test "get_project/1 fails if not sent a binary" do
    assert {:error, _msg} = ExCogmint.get_project!(123)
  end
  test "get_project/1 fails if sent a project uuid thats too short" do
    assert {:error, _msg} = ExCogmint.get_project!("tooshort")
  end



end
