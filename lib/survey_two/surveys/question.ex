defmodule SurveyTwo.Surveys.Question do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    field :text, :string
    field :type, :string
    field :required, :boolean, default: false
    field :options, {:array, :string}
    field :position, :integer, default: 0
    field :survey_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:text, :type, :required, :options, :position, :survey_id])
    |> validate_required([:text, :type, :required, :options, :position, :survey_id])
  end
end
