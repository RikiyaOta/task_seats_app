defmodule TaskSeat.Accounts.User.Auth do
  import Ecto.Query

  alias Comeonin.Bcrypt
  alias TaskSeat.Repo
  alias TaskSeat.Accounts.User

  def authenticate_user(email, plain_text_password) do
    query = from u in User, where: u.email == ^email
    case Repo.one(query) do
      nil ->
        Bcrypt.dummy_checkpw()
        {:error, :invalid_credential}
      user ->
        if Bcrypt.checkpw(plain_text_password, user.password) do
          {:ok, user}
        else
          {:error, :invalid_credential}
        end
    end
  end

end
