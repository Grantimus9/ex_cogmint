defmodule ExCogmint.Worktask do
  @moduledoc """
  Builds request URLs for API actions related to the Worktask object/struct.
  """
  alias ExCogmint.Config

  # "localhost:4000/api/v1/projects/add_task"
  def build_get_task_request(uuid) when is_binary(uuid) do
    %{
      path: "/api/v1/tasks/" <> uuid,
      method: :get
    }
  end
end
