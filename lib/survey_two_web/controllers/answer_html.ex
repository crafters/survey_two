defmodule SurveyTwoWeb.AnswerHTML do
  use SurveyTwoWeb, :html

  embed_templates "answer_html/*"

  @doc """
  Renders a answer form.

  The form is defined in the template at
  answer_html/answer_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def answer_form(assigns)
end
