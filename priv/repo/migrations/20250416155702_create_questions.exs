defmodule SurveyTwo.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false
      add :text, :text
      add :type, :string, null: false
      add :required, :boolean, default: false, null: false
      add :options, {:array, :text}
      add :position, :decimal
      add :survey_id, references(:surveys, on_delete: :nothing, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:questions, [:survey_id, :title])
    create unique_index(:questions, [:survey_id, :position])
  end
end
