defmodule SurveyTwoWeb.API.ResponseController do
  use SurveyTwoWeb, :controller

  alias SurveyTwo.Surveys

  def update(conn, %{"id" => id, "response" => response_params}) do
    response = Surveys.get_response!(id) |> SurveyTwo.Repo.preload(:answers)

    with {:ok, updated_response} <- update_response(response, response_params),
         {:ok, answers} <- save_answers(response, response_params["answers"]) do
      response_with_answers = %{updated_response | answers: answers}

      conn
      |> put_status(:ok)
      |> render(:show, response: response_with_answers)
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:error, changeset: changeset)
    end
  end

  defp save_answers(_response_id, nil), do: {:ok, []}

  defp save_answers(response, answers) when is_list(answers) do
    existing_answers = response.answers |> Enum.group_by(& &1.question_id)

    results =
      Enum.map(answers, fn answer_params ->
        question_id = answer_params["question_id"]
        existing_answer = Map.get(existing_answers, question_id, []) |> Enum.at(0)

        processed_params =
          case answer_params["value"] do
            value when is_list(value) ->
              Map.put(answer_params, "value", Jason.encode!(value))

            _ ->
              answer_params
          end

        params = Map.put(processed_params, "response_id", response.id)

        if existing_answer do
          Surveys.update_answer(existing_answer, params)
        else
          Surveys.create_answer(params)
        end
      end)

    errors =
      Enum.filter(results, fn
        {:error, _} -> true
        _ -> false
      end)

    if Enum.empty?(errors) do
      {:ok, Enum.map(results, fn {:ok, answer} -> answer end)}
    else
      List.first(errors)
    end
  end

  defp save_answers(_response_id, _answers), do: {:error, "Invalid answers format"}

  defp update_response(response, params) do
    response_params = Map.drop(params, ["answers"])

    if Enum.empty?(response_params) do
      {:ok, response}
    else
      Surveys.update_response(response, response_params)
    end
  end
end
