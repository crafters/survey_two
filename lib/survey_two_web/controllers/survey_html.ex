defmodule SurveyTwoWeb.SurveyHTML do
  use SurveyTwoWeb, :html

  embed_templates "survey_html/*"

  @doc """
  Renders a survey form.

  The form is defined in the template at
  survey_html/survey_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def survey_form(assigns)
end
