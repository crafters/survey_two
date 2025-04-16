defmodule SurveyTwoWeb.ResponseHTML do
  use SurveyTwoWeb, :html

  embed_templates "response_html/*"

  @doc """
  Renders a response form.

  The form is defined in the template at
  response_html/response_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def response_form(assigns)
end
