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



end
