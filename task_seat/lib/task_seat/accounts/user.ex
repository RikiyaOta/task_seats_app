defmodule TaskSeat.Accounts.User do
  use TaskSeat.Schema
  import Ecto.Changeset

  alias Comeonin.Bcrypt
  alias TaskSeat.Accounts.User
  alias TaskSeat.Tasks.Sheat
  alias TaskSeat.Tasks.Task

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string
    field :created_at, :utc_datetime
    field :created_by, :binary_id

    many_to_many :sheats, Sheat, join_through: "users_sheats", unique: true
    many_to_many :tasks, Task, join_through: "users_tasks", unique: true
  end

  @required_fields ~w(
    name
    email
    password
    created_at
    created_by
  )a

  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email, name: :uq_user_email)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end

  defp put_password_hash(changeset), do: changeset

end
