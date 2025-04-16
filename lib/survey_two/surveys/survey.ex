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
    |> validate_required([:title, :description, :active])
    |> maybe_generate_slug()
    |> unique_constraint(:slug)
  end
  
  defp maybe_generate_slug(changeset) do
    case {get_field(changeset, :slug), get_change(changeset, :title)} do
      {nil, title} when not is_nil(title) ->
        # Generate slug from title if slug is nil and title is provided
        slug = generate_slug(title)
        put_change(changeset, :slug, slug)
      {_slug, nil} ->
        # If title is nil but we're trying to update other fields, keep the existing slug
        changeset
      {nil, nil} ->
        # Both slug and title are nil, add error
        add_error(changeset, :title, "can't be blank when creating a slug")
      {_slug, _title} ->
        # Both exist, keep as is
        changeset
    end
  end
  
  defp generate_slug(title) do
    base_slug = title
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-") # Replace non-word chars with hyphens
    |> String.replace(~r/-+/, "-")        # Replace multiple hyphens with single hyphen
    |> String.trim("-")                  # Trim hyphens from beginning and end
    
    # Add a random suffix to help avoid collisions
    random_suffix = :crypto.strong_rand_bytes(3) |> Base.encode16(case: :lower)
    
    # Combine the base slug with the random suffix
    "#{base_slug}-#{random_suffix}"
  end
end
