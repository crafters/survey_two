defmodule SurveyTwoWeb.API.ResponseControllerTest do
  use SurveyTwoWeb.ConnCase

  import SurveyTwo.SurveysFixtures

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "update response" do
    setup [:create_survey_with_response_and_questions]

    test "updates response with answers", %{
      conn: conn,
      response: response,
      questions: [question1, question2]
    } do
      response_params = %{
        "answers" => [
          %{"question_id" => question1.id, "value" => "Answer 1"},
          %{"question_id" => question2.id, "value" => "Answer 2"}
        ]
      }

      conn = put(conn, ~p"/api/responses/#{response.id}", response: response_params)
      assert %{"data" => data} = json_response(conn, 200)
      assert data["id"] == response.id
      assert data["survey_id"] == response.survey_id
      assert length(data["answers"]) == 2

      [answer1, answer2] = data["answers"]
      assert answer1["question_id"] == question1.id
      assert answer1["value"] == "Answer 1"
      assert answer2["question_id"] == question2.id
      assert answer2["value"] == "Answer 2"
    end

    test "returns error when data is invalid", %{
      conn: conn,
      response: response,
      questions: [question]
    } do
      response_params = %{
        "answers" => [%{"question_id" => question.id, "value" => nil}]
      }

      conn = put(conn, ~p"/api/responses/#{response.id}", response: response_params)
      assert json_response(conn, 422)["errors"]
    end

    test "updates response without answers", %{conn: conn, response: response} do
      conn = put(conn, ~p"/api/responses/#{response.id}", response: %{})
      assert %{"data" => data} = json_response(conn, 200)
      assert data["id"] == response.id
      assert data["survey_id"] == response.survey_id
      assert data["answers"] == []
    end
  end

  defp create_survey_with_response_and_questions(_) do
    survey = survey_fixture()
    question1 = question_fixture(%{survey_id: survey.id, text: "Question 1"})
    question2 = question_fixture(%{survey_id: survey.id, text: "Question 2"})
    {:ok, response} = SurveyTwo.Surveys.create_response(%{survey_id: survey.id})

    %{survey: survey, questions: [question1, question2], response: response}
  end
end
