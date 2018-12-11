defmodule TaskSeat.Tasks.Category do
  use TaskSeat.Schema
  import Ecto.Changeset

  alias TaskSeat.Tasks.Category
  alias TaskSeat.Tasks.Sheat
  alias TaskSeat.Tasks.Task

  schema "categories" do
    field :name, :string
    field :color, :string
    field :created_at, :utc_datetime
    field :created_by, :binary_id
    field :modified_at, :utc_datetime
    field :modified_by, :binary_id

    belongs_to :sheat, Sheat
    has_many :tasks, Task
  end

  @required_fields ~w(
    name
    color
    sheat_id
    created_at
    created_by
    modified_at
    modified_by
  )a

  def changeset(%Category{} = category, attrs \\ %{}) do
    category
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:sheat_id, name: :fk_sheats)
  end

end
