defmodule TaskSheet.Accounts.SystemAccount do
  use TaskSheet.Schema
  import Ecto.Changeset
  
  alias TaskSheet.Accounts.SystemAccount

  schema "system_accounts" do
    field :name, :string
    field :email, :string
    field :password, :string
  end

  @required_fields ~w(
    name
    email
    password
  )a

  def changeset(%SystemAccount{} = system_account, attrs \\ %{}) do
    system_account
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email, name: :uq_system_account_email)
  end

end
