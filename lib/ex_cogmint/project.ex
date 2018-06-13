defmodule ExCogmint.Project do
  @moduledoc """
    Builds request URLs for API actions related to the Project
  """

  # "localhost:4000/api/v1/projects/add_task"
  def build_add_task_request(%{"project_uuid" => project_uuid, "substitutions" => substitutions}) do
    body =
      %{
        task: %{
          project_uuid: project_uuid,
          substitutions: substitutions,
          callback_url: Config.callback_url()
        }
      }
      |> Jason.encode!()

    %{
      path: "/api/v1/projects/add_task",
      body: body,
      method: :post
    }
  end
end
