defmodule TaskSeat.Tasks.Sheat do
  use TaskSeat.Schema
  import Ecto.Changeset

  alias TaskSeat.Tasks.Sheat
  alias TaskSeat.Accounts.User
  alias TaskSeat.Tasks.Category
  alias TaskSeat.Tasks.Task

  schema "sheats" do
    field :name, :string
    field :created_at, :utc_datetime
    field :created_by, :binary_id
    field :modified_at, :utc_datetime
    field :modified_by, :binary_id

    many_to_many :users, User, join_through: "users_sheats", unique: true
    has_many :categories, Category
    has_many :tasks, Task
  end

  @required_fields ~w(
    name
    created_at
    created_by
    modified_at
    modified_by
  )a

  def changeset(%Sheat{} = sheat, attrs \\ %{}) do
    sheat
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end

end


