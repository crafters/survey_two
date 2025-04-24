defmodule SurveyTwo.Surveys.Question do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    field :title, :string
    field :text, :string
    field :type, :string
    field :required, :boolean, default: false
    field :options, {:array, :string}
    field :position, :decimal
    field :deleted_at, :utc_datetime
    belongs_to :survey, SurveyTwo.Surveys.Survey, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:title, :text, :type, :required, :options, :position, :survey_id])
    |> validate_required([:title, :type, :required, :position, :survey_id])
    |> unique_constraint([:survey_id, :position], error_key: :position)
    |> unique_constraint([:survey_id, :title], error_key: :title)
    |> assoc_constraint(:survey)
  end
end
