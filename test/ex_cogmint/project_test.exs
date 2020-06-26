defmodule ExCogmint.ProjectTest do
  use ExUnit.Case, async: true
  alias ExCogmint.Project

  test "build_add_task_request/1" do
    project_uuid = "123"
    substitutions = %{"varname" => "new value"}

    r = Project.build_add_task_request(%{
      "project_uuid" => project_uuid,
      "substitutions" => substitutions
    })
    assert Map.has_key?(r, :body)
    assert Map.has_key?(r, :path)
  end

  test "build_add_task_request/1 returns an error if passed a mix of string and atom keys with duplicate keys" do
    project_uuid = "123"
    substitutions = %{"collision" => "value", collision: "some other value"}

    assert {:error, _} = Project.build_add_task_request(%{
      "project_uuid" => project_uuid,
      "substitutions" => substitutions
    })
  end

  test "build_add_task_request/1 succeeds even if given mixed map keys of different values" do
    project_uuid = "123"
    substitutions = %{"collision" => "value", atom_key: "some other value"}

    r = Project.build_add_task_request(%{
      "project_uuid" => project_uuid,
      "substitutions" => substitutions
    })

    assert Map.has_key?(r, :body)
    assert Map.has_key?(r, :path)
  end

  describe "ensure_substitutions_uses_same_key_type/1" do
    test "ensure_substitutions_uses_same_key_type/1 mixed keys" do
      m = %{"string" => "stringvalue", atom: "atomvalue"}
      assert {:ok, %{"string" => "stringvalue", "atom" => "atomvalue"}} = Project.ensure_substitutions_uses_same_key_type(m)
    end

    test "ensure_substitutions_uses_same_key_type/1 string keys input" do
      m = %{"string1" => "stringvalue", "string2" => "stringvalue2"}
      assert {:ok, m} == Project.ensure_substitutions_uses_same_key_type(m)
    end

    test "ensure_substitutions_uses_same_key_type/1 all atom keys are changed" do
      m = %{atom1: "stringvalue", atom2: "stringvalue2"}
      assert {:ok, %{"atom1" => "stringvalue", "atom2" => "stringvalue2"}} == Project.ensure_substitutions_uses_same_key_type(m)
    end

    test "Error if duplicate key exists in string and atom format" do
      m = %{"collision" => "stringvalue", collision: "atomvalue"}
      assert {:error, _} = Project.ensure_substitutions_uses_same_key_type(m)
    end
  end

  describe "all_unique_keys?/1" do
    test "all_unique_keys?/1 true" do
      assert %{"stringkey" => "1", other_key: "disregard"} |> Project.all_unique_keys?()
    end

    test "all_unique_keys?/1 false" do
      refute %{"samekey" => "1", samekey: "disregard"} |> Project.all_unique_keys?()
    end
  end

  describe "get_project/1" do
    
  end

end
