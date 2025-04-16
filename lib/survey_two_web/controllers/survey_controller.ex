defmodule SurveyTwoWeb.SurveyController do
  use SurveyTwoWeb, :controller

  alias SurveyTwo.Surveys
  alias SurveyTwo.Surveys.Survey

  def index(conn, _params) do
    surveys = Surveys.list_surveys()
    render(conn, :index, surveys: surveys)
  end

  def new(conn, _params) do
    changeset = Surveys.change_survey(%Survey{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"survey" => survey_params}) do
    case Surveys.create_survey(survey_params) do
      {:ok, survey} ->
        conn
        |> put_flash(:info, "Survey created successfully.")
        |> redirect(to: ~p"/surveys/#{survey}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    survey = Surveys.get_survey!(id)
    render(conn, :show, survey: survey)
  end

  def edit(conn, %{"id" => id}) do
    survey = Surveys.get_survey!(id)
    changeset = Surveys.change_survey(survey)
    render(conn, :edit, survey: survey, changeset: changeset)
  end

  def update(conn, %{"id" => id, "survey" => survey_params}) do
    survey = Surveys.get_survey!(id)

    case Surveys.update_survey(survey, survey_params) do
      {:ok, survey} ->
        conn
        |> put_flash(:info, "Survey updated successfully.")
        |> redirect(to: ~p"/surveys/#{survey}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, survey: survey, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    survey = Surveys.get_survey!(id)
    {:ok, _survey} = Surveys.delete_survey(survey)

    conn
    |> put_flash(:info, "Survey deleted successfully.")
    |> redirect(to: ~p"/surveys")
  end
end
