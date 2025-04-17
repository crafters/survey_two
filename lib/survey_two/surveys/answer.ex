defmodule SurveyTwo.Surveys.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "answers" do
    field :value, :string
    belongs_to :question, SurveyTwo.Surveys.Question
    belongs_to :response, SurveyTwo.Surveys.Response

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:value, :question_id, :response_id])
    |> validate_required([:value, :question_id, :response_id])
    |> unique_constraint([:question_id, :response_id])
    |> assoc_constraint(:question)
    |> assoc_constraint(:response)
  end
end
