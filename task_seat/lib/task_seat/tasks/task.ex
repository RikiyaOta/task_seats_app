defmodule TaskSeat.Tasks.Task do
  use TaskSeat.Schema
  import Ecto.Changeset

  alias TaskSeat.Tasks.Task
  alias TaskSeat.Tasks.Category
  alias TaskSeat.Tasks.Sheat

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
  end

  @required_fields ~w(
    title
    content
    importance
    urgency
    category_id
    sheat_id
    created_at
    created_by
    modified_at
    modified_by
  )a

  def changeset(%Task{} = task, attrs \\ %{}) do
    task
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> check_constraint(:importance, name: :ch_importance)
    |> check_constraint(:urgency, name: :ch_urgency)
    |> foreign_key_constraint(:category_id, name: :fk_categories)
    |> foreign_key_constraint(:sheat_id, name: :fk_sheats)
  end

end
