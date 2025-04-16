defmodule SurveyTwo.Surveys.Response do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "responses" do
    field :respondent_id, :string
    field :survey_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(response, attrs) do
    response
    |> cast(attrs, [:respondent_id])
    |> validate_required([:respondent_id])
  end
end
