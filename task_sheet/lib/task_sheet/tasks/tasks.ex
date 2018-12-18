defmodule TaskSheet.Tasks do
  @moduledoc """
    This module provide public API for Tasks context
  """

  import Ecto.Query

  alias TaskSheet.Repo
  alias TaskSheet.Accounts.User
  alias TaskSheet.Tasks.Task
  alias TaskSheet.Tasks.Sheet

  def get_sheet(id), do: Repo.get(Sheet, id)

  def get_sheet!(id), do: Repo.get!(Sheet, id)

  def get_sheets_of_user(%User{} = user) do
    user
    |> Repo.preload(:sheets)
    |> Map.get(:sheets)
  end

  def get_sheet_with_tasks(sheet_id) do
    query = from s in Sheet,
      left_join: t in assoc(s, :tasks),
      where: s.id == ^sheet_id,
      preload: [tasks: t]

    Repo.one(query)
  end

  def create_sheet(attrs \\ %{}) do
    %Sheet{}
    |> Sheet.changeset(attrs)
    |> Repo.insert()
  end

  def update_sheet(%Sheet{} = sheet, attrs \\ %{}) do
    sheet
    |> Sheet.changeset()
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
