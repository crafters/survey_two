defmodule SurveyTwoWeb.API.SurveyJSON do
  alias SurveyTwo.Surveys.Question
  alias SurveyTwo.Surveys.Survey

  @doc """
  Renders a single survey with its questions.
  """
  def show(%{survey: survey, questions: questions, response: response}) do
    %{
      survey: data(survey, questions, response)
    }
  end

  defp data(%Survey{} = survey, questions, response) do
    survey_data = %{
      id: survey.id,
      title: survey.title,
      description: survey.description,
      active: survey.active,
      slug: survey.slug,
      questions: for(question <- questions, do: question_data(question)),
      response: response_data(response)
    }

    survey_data
  end

  defp question_data(%Question{} = question) do
    %{
      id: question.id,
      title: question.title,
      text: question.text,
      type: question.type,
      required: question.required,
      options: question.options,
      position: decimal_to_string(question.position)
    }
  end

  defp response_data(%SurveyTwo.Surveys.Response{} = response) do
    %{
      id: response.id,
      respondent_id: response.respondent_id,
      answers: for(answer <- response.answers || [], do: answer_data(answer))
    }
  end

  defp answer_data(%SurveyTwo.Surveys.Answer{} = answer) do
    %{
      id: answer.id,
      value: answer.value,
      question_id: answer.question_id,
      response_id: answer.response_id
    }
  end

  defp decimal_to_string(decimal) when is_struct(decimal, Decimal) do
    Decimal.to_string(decimal)
  end

  defp decimal_to_string(value), do: value
end
