defmodule SurveyTwo.SurveysFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SurveyTwo.Surveys` context.
  """

  @doc """
  Generate a survey.
  """
  def survey_fixture(attrs \\ %{}) do
    {:ok, survey} =
      attrs
      |> Enum.into(%{
        active: true,
        description: "some description",
        slug: "some slug",
        title: "some title"
      })
      |> SurveyTwo.Surveys.create_survey()

    survey
  end

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        options: ["option1", "option2"],
        position: 42,
        required: true,
        text: "some text",
        type: "some type"
      })
      |> SurveyTwo.Surveys.create_question()

    question
  end

  @doc """
  Generate a response.
  """
  def response_fixture(attrs \\ %{}) do
    {:ok, response} =
      attrs
      |> Enum.into(%{
        respondent_id: "some respondent_id"
      })
      |> SurveyTwo.Surveys.create_response()

    response
  end

  @doc """
  Generate a answer.
  """
  def answer_fixture(attrs \\ %{}) do
    {:ok, answer} =
      attrs
      |> Enum.into(%{
        value: "some value"
      })
      |> SurveyTwo.Surveys.create_answer()

    answer
  end
end
