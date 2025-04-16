defmodule SurveyTwo.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :value, :text
      add :question_id, references(:questions, on_delete: :nothing, type: :binary_id)
      add :response_id, references(:responses, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:answers, [:question_id])
    create index(:answers, [:response_id])
  end
end
