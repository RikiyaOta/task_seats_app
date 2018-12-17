defmodule TaskSeat.Tasks do
  @moduledoc """
    This module provide public API for Tasks context
  """

  alias TaskSeat.Repo
  alias TaskSeat.Accounts.User

  def get_sheats_of_user(%User{} = user) do
    user
    |> Repo.preload(:sheats)
    |> Map.get(:sheats)
  end

end
