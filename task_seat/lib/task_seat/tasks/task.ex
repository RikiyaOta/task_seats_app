defmodule TaskSeat.Tasks.Task do
  use TaskSeat.Schema
  import Ecto.Changeset

  alias TaskSeat.Tasks.Task

  schema "tasks" do
    field :title, :string
    field :content, :string
    field :importance, :integer
    field :urgency, :integer
    field :created_at, :utc_datetime
    field :created_by, :binary_id
    field :modified_at, :utc_datetime
    field :modified_by, :binary_id
  end

  @required_fields ~w(
    title
    content
    importance
    urgency
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
  end

end
