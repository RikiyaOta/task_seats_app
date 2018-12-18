defmodule TaskSeatWeb.Tasks.TaskController do
  use TaskSeatWeb, :controller

  use Timex
  require Logger

  alias TaskSeat.Tasks
  alias TaskSeat.Tasks.Task
  alias TaskSeat.Accounts
  alias TaskSeat.Accounts.Auth.Guardian

  def show(conn, %{"task_id" => task_id}) do
    task = Tasks.get_task!(task_id)
    conn
    |> assign(:conn, conn)
    |> assign(:task, task)
    |> render("show.html")
  end

  def new(conn, %{"sheat_id" => sheat_id}) do
    changeset = Task.changeset(%Task{})
    action = task_seat_tasks_task_path(conn, :create, sheat_id)
    sheat = Tasks.get_sheat!(sheat_id)

    conn
    |> assign(:conn, conn)
    |> assign(:changeset, changeset)
    |> assign(:action, action)
    |> assign(:sheat, sheat)
    |> render("new.html")
  end

  def create(conn, %{"sheat_id" => sheat_id, "task" => %{"title" => title, "content" => content, "urgency" => urgency, "importance" => importance}}) do
    sheat = Tasks.get_sheat_with_tasks(sheat_id)
    now = Timex.now
    current_user = Guardian.current_user(conn)
    task_params = %{
      title: title,
      content: content,
      urgency: urgency,
      importance: importance,
      sheat_id: sheat_id,
      created_at: now,
      created_by: current_user.id,
      modified_at: now,
      modified_by: current_user.id
    }

    case Tasks.create_task(task_params) do
      {:ok, result} ->
        Logger.info "________[SUCESS]________ TaskController.create"
        Logger.info inspect(result)
        conn
        |> put_flash(:info, "タスク作成完了しました。")
        |> redirect(to: task_seat_tasks_sheat_path(conn, :show, sheat.id))
      {:error, %Ecto.Changeset{} = error} ->
        Logger.error "________[ERROR]________ TaskController.create"
        Logger.error inspect(error)
        conn
        |> put_flash(:error, "タスク作成に失敗しました。")
        |> assign(:conn, conn)
        |> assign(:changeset, error)
        |> assign(:action, task_seat_tasks_task_path(conn, :create, sheat.id))
        |> assign(:sheat, sheat)
        |> render("new.html")
    end

  end

  def edit(conn, %{"task_id" => task_id}) do
    changeset = Tasks.get_task!(task_id) |> Task.changeset()
    action    = task_seat_tasks_task_path(conn, :update, task_id)
    conn
    |> assign(:changeset, changeset)
    |> assign(:action, action)
    |> render("edit.html")
  end

  def update(conn, %{"task_id" => task_id, "task" => %{"title" => title, "content" => content, "urgency" => urgency, "importance" => importance}}) do
    now = Timex.now
    current_user = Guardian.current_user(conn)
    target_task = Tasks.get_task!(task_id)
    task_params = %{
      title: title,
      content: content,
      urgency: urgency,
      importance: importance,
      modified_at: now,
      modified_by: current_user.id
    }

    case Tasks.update_task(target_task, task_params) do
      {:ok, %Task{} = updated_task} ->
        Logger.info "________[SUCCESS]________ TaskController.update"
        Logger.info inspect(updated_task)
        conn
        |> put_flash(:info, "タスクを更新しました。")
        |> redirect(to: task_seat_tasks_task_path(conn, :show, task_id))
      {:error, %Ecto.Changeset{} = error} ->
        Logger.error "________[ERROR]________ TaskController.update"
        Logger.error inspect(error)
        conn
        |> put_flash(:error, "タスクの更新でエラーが発生しました。")
        |> assign(:changeset, error)
        |> assign(:action, task_seat_tasks_task_path(conn, :update, task_id))
        |> render("edit.html")
    end
  end

end
