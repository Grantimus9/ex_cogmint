defmodule ExCogmint.WorktaskTest do
  use ExUnit.Case, async: true
  alias ExCogmint.Worktask

  test "build_get_task_request/1" do
    uuid = "b58acbd2-a72e-44d7-ae7c-59ebc9852a54"

    expected = %{
      path: "/api/v1/tasks/b58acbd2-a72e-44d7-ae7c-59ebc9852a54",
      method: :get
    }

    assert expected == Worktask.build_get_task_request(uuid)
  end
end
