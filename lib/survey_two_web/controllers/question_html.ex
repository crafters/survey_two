defmodule SurveyTwoWeb.QuestionHTML do
  use SurveyTwoWeb, :html

  embed_templates "question_html/*"

  @doc """
  Renders a question form.

  The form is defined in the template at
  question_html/question_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def question_form(assigns)
end
