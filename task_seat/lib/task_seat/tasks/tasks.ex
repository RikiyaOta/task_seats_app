defmodule TaskSheet.Tasks do
  @moduledoc """
    This module provide public API for Tasks context
  """

  import Ecto.Query

  alias TaskSheet.Repo
  alias TaskSheet.Accounts.User
  alias TaskSheet.Tasks.Task
  alias TaskSheet.Tasks.Sheat

  def get_sheat(id), do: Repo.get(Sheat, id)

  def get_sheat!(id), do: Repo.get!(Sheat, id)

  def get_sheats_of_user(%User{} = user) do
    user
    |> Repo.preload(:sheats)
    |> Map.get(:sheats)
  end

  def get_sheat_with_tasks(sheat_id) do
    query = from s in Sheat,
      left_join: t in assoc(s, :tasks),
      where: s.id == ^sheat_id,
      preload: [tasks: t]

    Repo.one(query)
  end

  def create_sheat(attrs \\ %{}) do
    %Sheat{}
    |> Sheat.changeset(attrs)
    |> Repo.insert()
  end

  def update_sheat(%Sheat{} = sheat, attrs \\ %{}) do
    sheat
    |> Sheat.changeset()
    |> Repo.update()
  end


  def get_task(task_id), do: Repo.get(Task, task_id)

  def get_task!(task_id), do: Repo.get!(Task, task_id)

  def create_task(params \\ %{}) do
    %Task{}
    |> Task.changeset(params)
    |> Repo.insert()
  end

  def update_task(%Task{} = task, params \\ %{}) do
    task
    |> Task.changeset(params)
    |> Repo.update()
  end

end
