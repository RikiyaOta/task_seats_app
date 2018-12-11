defmodule TaskSeat.Accounts do
  @moduledoc """
    This module provide public API for Accounts context.
  """

  import Ecto.Query
  alias TaskSeat.Repo
  alias TaskSeat.Accounts.SystemAccount
  alias TaskSeat.Accounts.User

  # User 
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  # SystemAccount
  def change_system_account(%SystemAccount{} = system_account, attrs \\ %{}) do
    SystemAccount.changeset(system_account, attrs)
  end

  def create_system_account(attrs) do
    %SystemAccount{}
    |> SystemAccount.changeset(attrs)
    |> Repo.insert()
  end

  def update_system_account(%SystemAccount{} = system_account, attrs) do
    system_account
    |> SystemAccount.changeset(attrs)
    |> Repo.update()
  end

end
