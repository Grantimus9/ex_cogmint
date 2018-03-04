defmodule ExCogmint do
  @moduledoc """
  Documentation for ExCogmint.
  """

  @doc """
  Add a task to an existing project. Requires that you know the project's UUID, and
  pass in the variable names you wish to substitute, along with their values.

  ## Examples


  """
  # Substitutions could be a keyword list or a map of kv pairs. project_uuid must be a string.
  def add_task!(nil, _), do: {:error, "project_uuid was nil."}
  def add_task!(_, nil), do: {:error, "substitutions was nil"}
  def add_task!(_, %{}), do: {:error, "substitutions map was empty"}

  def add_task!(project_uuid, substitutions)
      when is_map(substitutions) and is_binary(project_uuid) do
    %{"project_uuid" => project_uuid, "substitutions" => substitutions}
    |> ExCogmint.Project.build_add_task_request()
    |> ExCogmint.Client.request!()
  end
end
