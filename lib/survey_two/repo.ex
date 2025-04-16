defmodule SurveyTwo.Repo do
  use Ecto.Repo,
    otp_app: :survey_two,
    adapter: Ecto.Adapters.Postgres
end
