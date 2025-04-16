defmodule SurveyTwo.Surveys do
  @moduledoc """
  The Surveys context.
  """

  import Ecto.Query, warn: false
  alias SurveyTwo.Repo

  alias SurveyTwo.Surveys.Survey

  @doc """
  Returns the list of surveys.

  ## Examples

      iex> list_surveys()
      [%Survey{}, ...]

  """
  def list_surveys do
    Repo.all(Survey)
  end

  @doc """
  Gets a single survey.

  Raises `Ecto.NoResultsError` if the Survey does not exist.

  ## Examples

      iex> get_survey!(123)
      %Survey{}

      iex> get_survey!(456)
      ** (Ecto.NoResultsError)

  """
  def get_survey!(id), do: Repo.get!(Survey, id)

  @doc """
  Creates a survey.

  ## Examples

      iex> create_survey(%{field: value})
      {:ok, %Survey{}}

      iex> create_survey(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_survey(attrs \\ %{}) do
    %Survey{}
    |> Survey.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a survey.

  ## Examples

      iex> update_survey(survey, %{field: new_value})
      {:ok, %Survey{}}

      iex> update_survey(survey, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_survey(%Survey{} = survey, attrs) do
    survey
    |> Survey.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a survey.

  ## Examples

      iex> delete_survey(survey)
      {:ok, %Survey{}}

      iex> delete_survey(survey)
      {:error, %Ecto.Changeset{}}

  """
  def delete_survey(%Survey{} = survey) do
    Repo.delete(survey)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking survey changes.

  ## Examples

      iex> change_survey(survey)
      %Ecto.Changeset{data: %Survey{}}

  """
  def change_survey(%Survey{} = survey, attrs \\ %{}) do
    Survey.changeset(survey, attrs)
  end

  alias SurveyTwo.Surveys.Question

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions(survey_id) do
    from(q in Question, where: q.survey_id == ^survey_id, order_by: [asc: :position])
    |> Repo.all()
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id), do: Repo.get!(Question, id)

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{data: %Question{}}

  """
  def change_question(%Question{} = question, attrs \\ %{}) do
    Question.changeset(question, attrs)
  end

  alias SurveyTwo.Surveys.Response

  @doc """
  Returns the list of responses.

  ## Examples

      iex> list_responses()
      [%Response{}, ...]

  """
  def list_responses do
    Repo.all(Response)
  end

  @doc """
  Gets a single response.

  Raises `Ecto.NoResultsError` if the Response does not exist.

  ## Examples

      iex> get_response!(123)
      %Response{}

      iex> get_response!(456)
      ** (Ecto.NoResultsError)

  """
  def get_response!(id), do: Repo.get!(Response, id)

  @doc """
  Creates a response.

  ## Examples

      iex> create_response(%{field: value})
      {:ok, %Response{}}

      iex> create_response(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_response(attrs \\ %{}) do
    %Response{}
    |> Response.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a response.

  ## Examples

      iex> update_response(response, %{field: new_value})
      {:ok, %Response{}}

      iex> update_response(response, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_response(%Response{} = response, attrs) do
    response
    |> Response.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a response.

  ## Examples

      iex> delete_response(response)
      {:ok, %Response{}}

      iex> delete_response(response)
      {:error, %Ecto.Changeset{}}

  """
  def delete_response(%Response{} = response) do
    Repo.delete(response)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking response changes.

  ## Examples

      iex> change_response(response)
      %Ecto.Changeset{data: %Response{}}

  """
  def change_response(%Response{} = response, attrs \\ %{}) do
    Response.changeset(response, attrs)
  end

  alias SurveyTwo.Surveys.Answer

  @doc """
  Returns the list of answers.

  ## Examples

      iex> list_answers()
      [%Answer{}, ...]

  """
  def list_answers do
    Repo.all(Answer)
  end

  @doc """
  Gets a single answer.

  Raises `Ecto.NoResultsError` if the Answer does not exist.

  ## Examples

      iex> get_answer!(123)
      %Answer{}

      iex> get_answer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_answer!(id), do: Repo.get!(Answer, id)

  @doc """
  Creates a answer.

  ## Examples

      iex> create_answer(%{field: value})
      {:ok, %Answer{}}

      iex> create_answer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_answer(attrs \\ %{}) do
    %Answer{}
    |> Answer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a answer.

  ## Examples

      iex> update_answer(answer, %{field: new_value})
      {:ok, %Answer{}}

      iex> update_answer(answer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_answer(%Answer{} = answer, attrs) do
    answer
    |> Answer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a answer.

  ## Examples

      iex> delete_answer(answer)
      {:ok, %Answer{}}

      iex> delete_answer(answer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_answer(%Answer{} = answer) do
    Repo.delete(answer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking answer changes.

  ## Examples

      iex> change_answer(answer)
      %Ecto.Changeset{data: %Answer{}}

  """
  def change_answer(%Answer{} = answer, attrs \\ %{}) do
    Answer.changeset(answer, attrs)
  end
end
