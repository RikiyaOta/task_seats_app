defmodule TaskSeat.Accounts.User.Guardian do
  use Guardian, otp_app: :task_seat

  require Logger

  alias TaskSeat.Accounts

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => user_id}) do
    Logger.info "###Guardian.resource_not_found###"
    case Accounts.get_user(user_id) do
      nil -> 
        Logger.error "NOT FOUND"
        {:error, :resource_not_found}
      user -> 
        Logger.info "FOUND RESOURCE"
        Logger.info inspect(user)
        {:ok, user}
    end
  end

end
