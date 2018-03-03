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
  def add_task!(project_uuid, substitutions) do
    %{"project_uuid" => project_uuid, "substitutions" => substitutions}
    |> ExCogmint.Project.build_add_task_request()
    |> ExCogmint.Client.request!
  end




end
