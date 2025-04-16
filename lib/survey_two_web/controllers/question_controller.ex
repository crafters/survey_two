defmodule SurveyTwoWeb.QuestionController do
  use SurveyTwoWeb, :controller

  alias SurveyTwo.Surveys
  alias SurveyTwo.Surveys.Question

  def index(conn, %{"survey_id" => survey_id}) do
    survey = Surveys.get_survey!(survey_id)
    questions = Surveys.list_questions(survey_id)
    render(conn, :index, survey: survey, questions: questions)
  end

  def new(conn, %{"survey_id" => survey_id}) do
    survey = Surveys.get_survey!(survey_id)
    changeset = Surveys.change_question(%Question{})
    render(conn, :new, survey: survey, changeset: changeset)
  end

  def create(conn, %{"question" => question_params, "survey_id" => survey_id}) do
    attrs = Map.put(question_params, "survey_id", survey_id)

    case Surveys.create_question(attrs) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question created successfully.")
        |> redirect(to: ~p"/surveys/#{survey_id}/questions/#{question}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def reorder(conn, %{"id" => id, "survey_id" => survey_id}) do
    survey = Surveys.get_survey!(survey_id)
    question = Surveys.get_question!(id)
    changeset = Surveys.change_question(question)
    render(conn, :edit, survey: survey, question: question, changeset: changeset)
  end

  def show(conn, %{"id" => id, "survey_id" => survey_id}) do
    survey = Surveys.get_survey!(survey_id)
    question = Surveys.get_question!(id)
    render(conn, :show, survey: survey, question: question)
  end

  def edit(conn, %{"id" => id, "survey_id" => survey_id}) do
    survey = Surveys.get_survey!(survey_id)
    question = Surveys.get_question!(id)
    changeset = Surveys.change_question(question)
    render(conn, :edit, survey: survey, question: question, changeset: changeset)
  end

  def update(conn, %{"id" => id, "question" => question_params, "survey_id" => survey_id}) do
    question = Surveys.get_question!(id)

    attrs = Map.put(question_params, "survey_id", survey_id)

    case Surveys.update_question(question, attrs) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question updated successfully.")
        |> redirect(to: ~p"/surveys/#{survey_id}/questions/#{question}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, question: question, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "survey_id" => survey_id}) do
    question = Surveys.get_question!(id)
    {:ok, _question} = Surveys.delete_question(question)

    conn
    |> put_flash(:info, "Question deleted successfully.")
    |> redirect(to: ~p"/surveys/#{survey_id}/questions")
  end
end
