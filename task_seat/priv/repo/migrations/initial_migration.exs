defmodule TaskSheet.Repo.Migrations do

  alias TaskSheet.Repo

  def main do
    File.read!("priv/repo/migrations/init.sql")
    |> String.split(";")
    |> Enum.each(fn sql -> Repo.query!(sql) end)
  end

end

TaskSheet.Repo.Migrations.main()
