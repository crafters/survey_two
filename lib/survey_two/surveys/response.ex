defmodule SurveyTwo.Surveys.Response do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "responses" do
    field :respondent_id, :string

    belongs_to :survey, SurveyTwo.Surveys.Survey
    has_many :answers, SurveyTwo.Surveys.Answer, preload_order: [asc: :inserted_at]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(response, attrs) do
    response
    |> cast(attrs, [:respondent_id, :survey_id])
    |> validate_required([:survey_id])
    |> assoc_constraint(:survey)
  end
end
