defmodule ExCogmint.Project do
  @moduledoc """
    Builds request URLs for API actions related to the Project object/struct
  """
  alias ExCogmint.Config

  def build_add_task_request(%{"project_uuid" => project_uuid, "substitutions" => substitutions}) do
    with {:ok, substitutions} <- ensure_substitutions_uses_same_key_type(substitutions)
    do
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
    else
      err -> err
    end
  end

  def ensure_substitutions_uses_same_key_type(map) when is_map(map) do
    case all_unique_keys?(map) do
      true ->
        map =
          map
          |> Enum.map(fn({k, v}) -> {to_string(k), v} end)
          |> Enum.into(%{})

        {:ok, map}

      false ->
        {:error, "Received a map of mixed string and atom keys and could not normalize the keys to strings because there was a string key that matched an atom key."}
    end
  end

  def all_unique_keys?(map) when is_map(map) do
    u_keys =
      map
      |> Map.keys()
      |> Enum.map(&to_string/1)
      |> Enum.uniq()

    Enum.count(u_keys) == Enum.count(Map.keys(map))
  end

end
