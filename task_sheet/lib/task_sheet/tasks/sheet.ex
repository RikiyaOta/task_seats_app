defmodule TaskSheet.Tasks.Sheet do
  use TaskSheet.Schema
  import Ecto.Changeset

  alias TaskSheet.Tasks.Sheet
  alias TaskSheet.Accounts.User
  alias TaskSheet.Tasks.Category
  alias TaskSheet.Tasks.Task

  schema "sheets" do
    field :name, :string
    field :created_at, :utc_datetime
    field :created_by, :binary_id
    field :modified_at, :utc_datetime
    field :modified_by, :binary_id

    many_to_many :users, User, join_through: "users_sheets", unique: true
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

  def changeset(%Sheet{} = sheet, attrs \\ %{}) do
    sheet
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end

end


