defmodule SurveyTwoWeb.API.SurveyController do
  use SurveyTwoWeb, :controller

  alias SurveyTwo.Repo
  alias SurveyTwo.Surveys

  def show(conn, %{"id" => id}) do
    survey = Surveys.get_survey!(id)
    questions = Surveys.list_questions(survey.id)
    response_id = get_session(conn, :response_id)

    {response, conn} =
      if response_id do
        response = Surveys.get_response!(response_id) |> Repo.preload(:answers)
        {response, conn}
      else
        {:ok, response} = Surveys.create_response(%{survey_id: id})
        response = Repo.preload(response, :answers)
        {response, put_session(conn, :response_id, response.id)}
      end

    render(conn, :show, survey: survey, questions: questions, response: response)
  end

  def clear_session(conn, %{"id" => id}) do
    conn
    |> delete_session(:response_id)
    |> json(%{status: "success", message: "Session cleared", survey_id: id})
  end
end
