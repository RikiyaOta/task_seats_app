# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskSheet.Repo.insert!(%TaskSheet.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule TaskSheet.Repo.DataSeeder do
  alias TaskSheet.Repo

  def main do
    File.cd!("priv/repo/seeds")
    File.ls!()
    |> Enum.filter(fn file_name -> String.ends_with?(file_name, ".sql") end) #.swpファイルとかあっても無視したい
    |> Enum.each(fn file_name -> 
      File.read!(file_name) 
      |> String.split(";") 
      |> Enum.each(fn sql -> Repo.query!(sql) end)
    end)
  end

end

TaskSheet.Repo.DataSeeder.main()
