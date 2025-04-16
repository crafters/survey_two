defmodule SurveyTwo.Repo.Migrations.CreateSurveys do
  use Ecto.Migration

  def change do
    create table(:surveys, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :text
      add :active, :boolean, default: false, null: false
      add :slug, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:surveys, [:slug])
  end
end
