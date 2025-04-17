defmodule SurveyTwoWeb.ReactController do
  use SurveyTwoWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
