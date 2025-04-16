defmodule SurveyTwo.Surveys.Survey do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "surveys" do
    field :title, :string
    field :description, :string
    field :active, :boolean, default: false
    field :slug, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(survey, attrs) do
    survey
    |> cast(attrs, [:title, :description, :active, :slug])
    |> validate_required([:title, :description, :active, :slug])
  end
end
