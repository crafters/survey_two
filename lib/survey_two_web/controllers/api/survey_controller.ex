defmodule SurveyTwoWeb.API.SurveyController do
  use SurveyTwoWeb, :controller

  alias SurveyTwo.Surveys
  # alias SurveyTwo.Surveys.Survey

  def show(conn, %{"id" => id}) do
    survey = Surveys.get_survey!(id)
    questions = Surveys.list_questions(survey.id)

    render(conn, :show, survey: survey, questions: questions)
  end
end
