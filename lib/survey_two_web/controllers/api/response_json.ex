defmodule SurveyTwoWeb.API.ResponseJSON do
  alias SurveyTwo.Repo
  alias SurveyTwo.Surveys.Response

  def show(%{response: response}) do
    %{
      data: data(response)
    }
  end

  def error(%{changeset: changeset}) do
    %{
      errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
    }
  end

  defp data(%Response{} = response) do
    response = Repo.preload(response, :answers)

    %{
      id: response.id,
      survey_id: response.survey_id,
      inserted_at: response.inserted_at,
      answers:
        Enum.map(response.answers, fn answer ->
          %{
            id: answer.id,
            question_id: answer.question_id,
            value: answer.value
          }
        end)
    }
  end

  defp translate_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
