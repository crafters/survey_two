defmodule SurveyTwoWeb.ResponseController do
  use SurveyTwoWeb, :controller

  alias SurveyTwo.Surveys
  alias SurveyTwo.Surveys.Answer

  def index(conn, %{"survey_id" => survey_id}) do
    survey = Surveys.list_survey_with_responses(survey_id)
    render(conn, :index, responses: survey.responses, survey: survey)
  end

  def show(conn, %{"id" => id}) do
    response = Surveys.get_response!(id)
    answer_changeset = Surveys.change_answer(%Answer{})
    render(conn, :show, response: response, answer_changeset: answer_changeset)
  end

  def add_answer(conn, %{"response_id" => id, "answer" => answer_params}) do
    response = Surveys.get_response!(id)
    answer_params = Map.put(answer_params, "response_id", id)

    case Surveys.create_answer(answer_params) do
      {:ok, _answer} ->
        conn
        |> put_flash(:info, "Answer added successfully.")
        |> redirect(to: ~p"/surveys/#{response.survey_id}/responses/#{id}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :show, response: response, answer_changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    response = Surveys.get_response!(id)
    {:ok, _response} = Surveys.delete_response(response)

    conn
    |> put_flash(:info, "Response deleted successfully.")
    |> redirect(to: ~p"/surveys/#{response.survey_id}/responses")
  end
end
