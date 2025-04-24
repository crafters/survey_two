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

      add :deleted_at, :utc_datetime
      timestamps(type: :utc_datetime)
    end

    create unique_index(:questions, [:survey_id, :title])
    create unique_index(:questions, [:survey_id, :position])

    execute """
            CREATE OR REPLACE RULE soft_deletion AS ON DELETE TO questions
            DO INSTEAD UPDATE questions SET deleted_at = NOW() WHERE id = OLD.id AND deleted_at IS NULL RETURNING OLD.*;
            """,
            """
            DROP RULE IF EXISTS soft_deletion ON questions;
            """
  end
end
