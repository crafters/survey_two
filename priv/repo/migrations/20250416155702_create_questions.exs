defmodule SurveyTwo.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :string
      add :type, :string
      add :required, :boolean, default: false, null: false
      add :options, {:array, :string}
      add :position, :integer
      add :survey_id, references(:surveys, on_delete: :nothing, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:questions, [:survey_id])
  end
end
