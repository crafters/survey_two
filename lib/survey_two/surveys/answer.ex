defmodule SurveyTwo.Surveys.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "answers" do
    field :value, :string
    field :question_id, :binary_id
    field :response_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
