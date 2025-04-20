defmodule SurveyTwo.Surveys.Slug do
  @moduledoc """
    Slug is a module that generates a string to be used as the slug.
    Generated slug will exclude i, o, l characters and use only lowercase
    for better URL compatibility.
  """

  @slug_default_length 5
  @alphabet ~c"0123456789abcdefghjkmnpqrstuvwxyz"

  def generate, do: generate(@slug_default_length)

  def generate(length) do
    for _ <- 1..length, into: "", do: <<Enum.random(@alphabet)>>
  end
end
