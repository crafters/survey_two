defmodule SurveyTwoWeb.ResponseControllerTest do
  use SurveyTwoWeb.ConnCase

  import SurveyTwo.SurveysFixtures

  @create_attrs %{respondent_id: "some respondent_id"}
  @update_attrs %{respondent_id: "some updated respondent_id"}
  @invalid_attrs %{respondent_id: nil}

  describe "index" do
    test "lists all responses", %{conn: conn} do
      conn = get(conn, ~p"/responses")
      assert html_response(conn, 200) =~ "Listing Responses"
    end
  end

  describe "new response" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/responses/new")
      assert html_response(conn, 200) =~ "New Response"
    end
  end

  describe "create response" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/responses", response: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/responses/#{id}"

      conn = get(conn, ~p"/responses/#{id}")
      assert html_response(conn, 200) =~ "Response #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/responses", response: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Response"
    end
  end

  describe "edit response" do
    setup [:create_response]

    test "renders form for editing chosen response", %{conn: conn, response: response} do
      conn = get(conn, ~p"/responses/#{response}/edit")
      assert html_response(conn, 200) =~ "Edit Response"
    end
  end

  describe "update response" do
    setup [:create_response]

    test "redirects when data is valid", %{conn: conn, response: response} do
      conn = put(conn, ~p"/responses/#{response}", response: @update_attrs)
      assert redirected_to(conn) == ~p"/responses/#{response}"

      conn = get(conn, ~p"/responses/#{response}")
      assert html_response(conn, 200) =~ "some updated respondent_id"
    end

    test "renders errors when data is invalid", %{conn: conn, response: response} do
      conn = put(conn, ~p"/responses/#{response}", response: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Response"
    end
  end

  describe "delete response" do
    setup [:create_response]

    test "deletes chosen response", %{conn: conn, response: response} do
      conn = delete(conn, ~p"/responses/#{response}")
      assert redirected_to(conn) == ~p"/responses"

      assert_error_sent 404, fn ->
        get(conn, ~p"/responses/#{response}")
      end
    end
  end

  defp create_response(_) do
    response = response_fixture()

    %{response: response}
  end
end
