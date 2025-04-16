defmodule SurveyTwo.Repo.Migrations.CreateResponses do
  use Ecto.Migration

  def change do
    create table(:responses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :respondent_id, :string
      add :survey_id, references(:surveys, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:responses, [:survey_id])
  end
end
