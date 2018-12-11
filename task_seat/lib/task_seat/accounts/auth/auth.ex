defmodule TaskSeat.Accounts.User.Auth do
  import Ecto.Query

  require Logger

  alias Comeonin.Bcrypt
  alias TaskSeat.Repo
  alias TaskSeat.Accounts.User

  def authenticate_user(email, plain_text_password) do
    Logger.info "###authenticate_user###"
    query = from u in User, where: u.email == ^email
    case Repo.one(query) do
      nil ->
        Bcrypt.dummy_checkpw()
        {:error, :invalid_credential}
      user ->
        if Bcrypt.checkpw(plain_text_password, user.password) do
          Logger.info "###AUTH OK###"
          {:ok, user}
        else
          {:error, :invalid_credential}
        end
    end
  end

end
