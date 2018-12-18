defmodule TaskSheetWeb.Tasks.TaskController do
  use TaskSheetWeb, :controller

  use Timex
  require Logger

  alias TaskSheet.Tasks
  alias TaskSheet.Tasks.Task
  alias TaskSheet.Accounts
  alias TaskSheet.Accounts.Auth.Guardian

  def show(conn, %{"task_id" => task_id}) do
    task = Tasks.get_task!(task_id)
    conn
    |> assign(:conn, conn)
    |> assign(:task, task)
    |> render("show.html")
  end

  def new(conn, %{"sheet_id" => sheet_id}) do
    changeset = Task.changeset(%Task{})
    action = task_sheet_tasks_task_path(conn, :create, sheet_id)
    sheet = Tasks.get_sheet!(sheet_id)

    conn
    |> assign(:conn, conn)
    |> assign(:changeset, changeset)
    |> assign(:action, action)
    |> assign(:sheet, sheet)
    |> render("new.html")
  end

  def create(conn, %{"sheet_id" => sheet_id, "task" => %{"title" => title, "content" => content, "urgency" => urgency, "importance" => importance}}) do
    sheet = Tasks.get_sheet_with_tasks(sheet_id)
    now = Timex.now
    current_user = Guardian.current_user(conn)
    task_params = %{
      title: title,
      content: content,
      urgency: urgency,
      importance: importance,
      sheet_id: sheet_id,
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
        |> redirect(to: task_sheet_tasks_sheet_path(conn, :show, sheet.id))
      {:error, %Ecto.Changeset{} = error} ->
        Logger.error "________[ERROR]________ TaskController.create"
        Logger.error inspect(error)
        conn
        |> put_flash(:error, "タスク作成に失敗しました。")
        |> assign(:conn, conn)
        |> assign(:changeset, error)
        |> assign(:action, task_sheet_tasks_task_path(conn, :create, sheet.id))
        |> assign(:sheet, sheet)
        |> render("new.html")
    end

  end

  def edit(conn, %{"task_id" => task_id}) do
    changeset = Tasks.get_task!(task_id) |> Task.changeset()
    action    = task_sheet_tasks_task_path(conn, :update, task_id)
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
        |> redirect(to: task_sheet_tasks_task_path(conn, :show, task_id))
      {:error, %Ecto.Changeset{} = error} ->
        Logger.error "________[ERROR]________ TaskController.update"
        Logger.error inspect(error)
        conn
        |> put_flash(:error, "タスクの更新でエラーが発生しました。")
        |> assign(:changeset, error)
        |> assign(:action, task_sheet_tasks_task_path(conn, :update, task_id))
        |> render("edit.html")
    end
  end

end
