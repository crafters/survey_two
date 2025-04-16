defmodule SurveyTwoWeb.API.SurveyJSON do
  alias SurveyTwo.Surveys.Question
  alias SurveyTwo.Surveys.Survey

  @doc """
  Renders a list of surveys.
  """
  def index(%{surveys: surveys}) do
    %{data: for(survey <- surveys, do: data(survey))}
  end

  @doc """
  Renders a single survey with its questions.
  """
  def show(%{survey: survey, questions: questions}) do
    %{
      survey: data(survey, questions)
    }
  end

  # For a single survey with questions
  defp data(%Survey{} = survey, questions) do
    survey_data = %{
      id: survey.id,
      title: survey.title,
      description: survey.description,
      active: survey.active,
      slug: survey.slug,
      questions: for(question <- questions, do: question_data(question))
    }

    survey_data
  end

  # For a survey without questions (used in index)
  defp data(%Survey{} = survey) do
    %{
      id: survey.id,
      title: survey.title,
      description: survey.description,
      active: survey.active,
      slug: survey.slug
    }
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

  # Helper function to convert Decimal to string
  defp decimal_to_string(decimal) when is_struct(decimal, Decimal) do
    Decimal.to_string(decimal)
  end

  defp decimal_to_string(value), do: value
end
