defmodule SurveyTwoWeb.ResponseController do
  use SurveyTwoWeb, :controller

  alias SurveyTwo.Surveys

  def index(conn, %{"survey_id" => survey_id}) do
    survey = Surveys.list_survey_with_responses(survey_id)
    render(conn, :index, responses: survey.responses, survey: survey)
  end

  def show(conn, %{"id" => id}) do
    response = Surveys.get_response!(id)
    render(conn, :show, response: response)
  end

  def delete(conn, %{"id" => id}) do
    response = Surveys.get_response!(id)
    {:ok, _response} = Surveys.delete_response(response)

    conn
    |> put_flash(:info, "Response deleted successfully.")
    |> redirect(to: ~p"/surveys/#{response.survey_id}/responses")
  end
end
