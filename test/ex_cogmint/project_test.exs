defmodule ExCogmint.ProjectTest do
  use ExUnit.Case, async: true
  alias ExCogmint.Project

  test "build_add_task_request/1" do
    project_uuid = "123"
    substitutions = %{"varname" => "new value"}

    Project.build_add_task_request(%{
      "project_uuid" => project_uuid,
      "substitutions" => substitutions
    })
  end

  test "build_add_task_request/1 fails if passed a mix of string and atom keys." do
    project_uuid = "123"
    substitutions = %{"varname" => "new value"}

    Project.build_add_task_request(%{
      "project_uuid" => project_uuid,
      "substitutions" => substitutions
    })
  end
  
end
