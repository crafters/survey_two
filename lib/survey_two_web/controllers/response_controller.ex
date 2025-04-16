defmodule SurveyTwoWeb.ResponseController do
  use SurveyTwoWeb, :controller

  alias SurveyTwo.Surveys
  alias SurveyTwo.Surveys.Response

  def index(conn, _params) do
    responses = Surveys.list_responses()
    render(conn, :index, responses: responses)
  end

  def new(conn, _params) do
    changeset = Surveys.change_response(%Response{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"response" => response_params}) do
    case Surveys.create_response(response_params) do
      {:ok, response} ->
        conn
        |> put_flash(:info, "Response created successfully.")
        |> redirect(to: ~p"/responses/#{response}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    response = Surveys.get_response!(id)
    render(conn, :show, response: response)
  end

  def edit(conn, %{"id" => id}) do
    response = Surveys.get_response!(id)
    changeset = Surveys.change_response(response)
    render(conn, :edit, response: response, changeset: changeset)
  end

  def update(conn, %{"id" => id, "response" => response_params}) do
    response = Surveys.get_response!(id)

    case Surveys.update_response(response, response_params) do
      {:ok, response} ->
        conn
        |> put_flash(:info, "Response updated successfully.")
        |> redirect(to: ~p"/responses/#{response}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, response: response, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    response = Surveys.get_response!(id)
    {:ok, _response} = Surveys.delete_response(response)

    conn
    |> put_flash(:info, "Response deleted successfully.")
    |> redirect(to: ~p"/responses")
  end
end
