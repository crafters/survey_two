defmodule SurveyTwo.Surveys.Survey do
  use Ecto.Schema
  import Ecto.Changeset
  alias SurveyTwo.Surveys.Slug

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "surveys" do
    field :title, :string
    field :description, :string
    field :active, :boolean, default: false
    field :thanks_message, :string
    field :slug, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(survey, attrs) do
    survey
    |> cast(attrs, [:title, :description, :active, :thanks_message, :slug])
    |> validate_required([:title, :description, :active])
    |> maybe_put_slug()
    |> unique_constraint(:slug)
  end

  defp maybe_put_slug(changeset) do
    case get_field(changeset, :slug) do
      nil -> put_change(changeset, :slug, Slug.generate())
      _slug -> changeset
    end
  end
end
