defmodule ExCogmint do
  @moduledoc """
    Documentation for ExCogmint.
  """

  @doc """
  Add a new task to an existing project.

  Project_uuid is the project's ID for which you wish to add a new microtask.

  The second argument is a map of substitutions you wish to make to the default project
  task template in order to create the task.

  For example, suppose you have a project asking users
  to determine if a city is a capital city or not. This project likely has a template that looks
  something like:

  "Is [[city]] a capital city?"

  For this project template, we can provide a map replacing the variable city with a value
  by passing in a map like

  `%{"city" => "Washington, D.C."}`

  Resulting in a task created for a worker like:

  "Is Washington, D.C. a capital city?"

  ## Examples

  `ExCogmint.add_task!("1234-12345-1234-12345", %{"city" => "Brasilia"})`
  `ExCogmint.add_task!("abc-123-abc", %{"variable_name_to_replace" => "string inserted"})`

  Will return either {:error, "helpful message"} or
  {:ok, %{"map" => "of", "created" => "task", "params" => "here"}}

  """
  # Substitutions could be a keyword list or a map of kv pairs. project_uuid must be a string.
  def add_task!(nil, _), do: {:error, "project_uuid was nil."}
  def add_task!(_, nil), do: {:error, "substitutions was nil"}
  def add_task!(_, map) when map == %{}, do: {:error, "substitutions map was empty"}

  def add_task!(project_uuid, substitutions)
      when is_map(substitutions) and is_binary(project_uuid) do
    %{"project_uuid" => project_uuid, "substitutions" => substitutions}
    |> ExCogmint.Project.build_add_task_request()
    |> ExCogmint.Client.request!()
  end

  @doc """
  Pings the server. Server will return with error if the client is using an invalid key,
  otherwise will return with whether or not the client is using a live key.
  Example Response:
  {:ok, %{"production_key" => true, "valid" => true}}
  """
  def ping() do
    %{
      path: "/api/v1/ping",
      body: "",
      method: :get
    }
    |> ExCogmint.Client.request!()
  end

  @doc """
  Gets information on a task ("worktask"). Returns the task, including associated submissions as a list of strings.
  """
  def get_task!(nil), do: {:error, "get_task! requires a UUID that is not nil"}
  def get_task!(""), do: {:error, "get_task! requires a UUID that is not blank"}
  def get_task!(uuid) when (false == is_binary(uuid)), do: {:error, "UUID should be a string binary"}
  def get_task!(uuid) when byte_size(uuid) < 36, do: {:error, "Invalid UUID: it should be 36 bytes"}

  def get_task!(uuid) when is_binary(uuid) do
    uuid
    |> ExCogmint.Worktask.build_get_task_request()
    |> ExCogmint.Client.request!()
  end
end
