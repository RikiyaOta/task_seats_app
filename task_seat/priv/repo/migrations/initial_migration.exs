defmodule TaskSeat.Repo.Migrations do

  alias TaskSeat.Repo

  def main do
    File.read!("priv/repo/migrations/init.sql")
    |> String.split(";")
    |> Enum.each(fn sql -> Repo.query!(sql) end)
  end

end

TaskSeat.Repo.Migrations.main()
