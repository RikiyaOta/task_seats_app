defmodule TaskSheet.Tasks.Task do
  use TaskSheet.Schema
  import Ecto.Changeset

  alias TaskSheet.Tasks.Task
  alias TaskSheet.Tasks.Category
  alias TaskSheet.Tasks.Sheat
  alias TaskSheet.Accounts.User

  schema "tasks" do
    field :title, :string
    field :content, :string
    field :importance, :integer
    field :urgency, :integer
    field :created_at, :utc_datetime
    field :created_by, :binary_id
    field :modified_at, :utc_datetime
    field :modified_by, :binary_id

    belongs_to :category, Category
    belongs_to :sheat, Sheat
    many_to_many :users, User, join_through: "users_tasks", unique: true
  end

  @required_fields ~w(
    title
    importance
    urgency
    sheat_id
    created_at
    created_by
    modified_at
    modified_by
  )a

  @optional_fields ~w(
    content
    category_id
  )a

  def changeset(%Task{} = task, attrs \\ %{}) do
    task
    |> cast(attrs, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> check_constraint(:importance, name: :ch_importance)
    |> check_constraint(:urgency, name: :ch_urgency)
    |> foreign_key_constraint(:category_id, name: :fk_categories)
    |> foreign_key_constraint(:sheat_id, name: :fk_sheats)
  end

end
