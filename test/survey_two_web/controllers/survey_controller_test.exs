defmodule SurveyTwoWeb.SurveyControllerTest do
  use SurveyTwoWeb.ConnCase

  import SurveyTwo.SurveysFixtures

  @create_attrs %{active: true, description: "some description", title: "some title", slug: "some slug"}
  @update_attrs %{active: false, description: "some updated description", title: "some updated title", slug: "some updated slug"}
  @invalid_attrs %{active: nil, description: nil, title: nil, slug: nil}

  describe "index" do
    test "lists all surveys", %{conn: conn} do
      conn = get(conn, ~p"/surveys")
      assert html_response(conn, 200) =~ "Listing Surveys"
    end
  end

  describe "new survey" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/surveys/new")
      assert html_response(conn, 200) =~ "New Survey"
    end
  end

  describe "create survey" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/surveys", survey: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/surveys/#{id}"

      conn = get(conn, ~p"/surveys/#{id}")
      assert html_response(conn, 200) =~ "Survey #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/surveys", survey: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Survey"
    end
  end

  describe "edit survey" do
    setup [:create_survey]

    test "renders form for editing chosen survey", %{conn: conn, survey: survey} do
      conn = get(conn, ~p"/surveys/#{survey}/edit")
      assert html_response(conn, 200) =~ "Edit Survey"
    end
  end

  describe "update survey" do
    setup [:create_survey]

    test "redirects when data is valid", %{conn: conn, survey: survey} do
      conn = put(conn, ~p"/surveys/#{survey}", survey: @update_attrs)
      assert redirected_to(conn) == ~p"/surveys/#{survey}"

      conn = get(conn, ~p"/surveys/#{survey}")
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, survey: survey} do
      conn = put(conn, ~p"/surveys/#{survey}", survey: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Survey"
    end
  end

  describe "delete survey" do
    setup [:create_survey]

    test "deletes chosen survey", %{conn: conn, survey: survey} do
      conn = delete(conn, ~p"/surveys/#{survey}")
      assert redirected_to(conn) == ~p"/surveys"

      assert_error_sent 404, fn ->
        get(conn, ~p"/surveys/#{survey}")
      end
    end
  end

  defp create_survey(_) do
    survey = survey_fixture()

    %{survey: survey}
  end
end
