defmodule TaskSheet.Accounts do
  @moduledoc """
    This module provide public API for Accounts context.
  """

  import Ecto.Query
  alias TaskSheet.Repo
  alias TaskSheet.Accounts.SystemAccount
  alias TaskSheet.Accounts.User
  alias TaskSheet.Tasks.Sheet

  # User 
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def get_user(user_id), do: Repo.get(User, user_id)

  def get_user!(user_id), do: Repo.get!(User, user_id)

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def create_user_with_associated_sheets(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Ecto.Changeset.cast_assoc(:sheets, with: &Sheet.changeset/2)
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

  def get_system_account(system_account_id), do: Repo.get(SystemAccount, system_account_id)

  def get_system_account!(system_account_id), do: Repo.get!(SystemAccount, system_account_id)

  def get_first_system_account, do: SystemAccount |> Ecto.Query.first |> Repo.one()

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
