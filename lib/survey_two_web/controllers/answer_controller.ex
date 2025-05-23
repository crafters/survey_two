defmodule SurveyTwoWeb.AnswerController do
  use SurveyTwoWeb, :controller

  alias SurveyTwo.Surveys
  alias SurveyTwo.Surveys.Answer

  def index(conn, _params) do
    answers = Surveys.list_answers()
    render(conn, :index, answers: answers)
  end

  def new(conn, _params) do
    changeset = Surveys.change_answer(%Answer{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"answer" => answer_params}) do
    case Surveys.create_answer(answer_params) do
      {:ok, answer} ->
        conn
        |> put_flash(:info, "Answer created successfully.")
        |> redirect(to: ~p"/answers/#{answer}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    answer = Surveys.get_answer!(id)
    render(conn, :show, answer: answer)
  end

  def edit(conn, %{"id" => id}) do
    answer = Surveys.get_answer!(id)
    changeset = Surveys.change_answer(answer)
    render(conn, :edit, answer: answer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "answer" => answer_params}) do
    answer = Surveys.get_answer!(id)

    case Surveys.update_answer(answer, answer_params) do
      {:ok, answer} ->
        conn
        |> put_flash(:info, "Answer updated successfully.")
        |> redirect(to: ~p"/answers/#{answer}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, answer: answer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    answer = Surveys.get_answer!(id)
    {:ok, _answer} = Surveys.delete_answer(answer)

    conn
    |> put_flash(:info, "Answer deleted successfully.")
    |> redirect(to: ~p"/answers")
  end
end
