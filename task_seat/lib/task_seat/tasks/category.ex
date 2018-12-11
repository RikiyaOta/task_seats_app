defmodule TaskSeat.Tasks.Category do
  use TaskSeat.Schema
  import Ecto.Changeset

  alias TaskSeat.Tasks.Category

  schema "categories" do
    field :name, :string
    field :color, :string
    field :created_at, :utc_datetime
    field :created_by, :binary_id
    field :modified_at, :utc_datetime
    field :modified_by, :binary_id
  end

  @required_fields ~w(
    name
    color
    created_at
    created_by
    modified_at
    modified_by
  )a

  def changeset(%Category{} = category, attrs \\ %{}) do
    category
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end

end
