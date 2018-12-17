defmodule TaskSeat.Tasks do
  @moduledoc """
    This module provide public API for Tasks context
  """

  import Ecto.Query

  alias TaskSeat.Repo
  alias TaskSeat.Accounts.User
  alias TaskSeat.Tasks.Sheat

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

end
