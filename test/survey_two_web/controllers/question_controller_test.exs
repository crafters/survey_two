defmodule SurveyTwoWeb.QuestionControllerTest do
  use SurveyTwoWeb.ConnCase

  import SurveyTwo.SurveysFixtures

  @create_attrs %{position: 42, type: "some type", options: ["option1", "option2"], text: "some text", required: true}
  @update_attrs %{position: 43, type: "some updated type", options: ["option1"], text: "some updated text", required: false}
  @invalid_attrs %{position: nil, type: nil, options: nil, text: nil, required: nil}

  describe "index" do
    test "lists all questions", %{conn: conn} do
      conn = get(conn, ~p"/questions")
      assert html_response(conn, 200) =~ "Listing Questions"
    end
  end

  describe "new question" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/questions/new")
      assert html_response(conn, 200) =~ "New Question"
    end
  end

  describe "create question" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/questions", question: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/questions/#{id}"

      conn = get(conn, ~p"/questions/#{id}")
      assert html_response(conn, 200) =~ "Question #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/questions", question: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Question"
    end
  end

  describe "edit question" do
    setup [:create_question]

    test "renders form for editing chosen question", %{conn: conn, question: question} do
      conn = get(conn, ~p"/questions/#{question}/edit")
      assert html_response(conn, 200) =~ "Edit Question"
    end
  end

  describe "update question" do
    setup [:create_question]

    test "redirects when data is valid", %{conn: conn, question: question} do
      conn = put(conn, ~p"/questions/#{question}", question: @update_attrs)
      assert redirected_to(conn) == ~p"/questions/#{question}"

      conn = get(conn, ~p"/questions/#{question}")
      assert html_response(conn, 200) =~ "some updated text"
    end

    test "renders errors when data is invalid", %{conn: conn, question: question} do
      conn = put(conn, ~p"/questions/#{question}", question: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Question"
    end
  end

  describe "delete question" do
    setup [:create_question]

    test "deletes chosen question", %{conn: conn, question: question} do
      conn = delete(conn, ~p"/questions/#{question}")
      assert redirected_to(conn) == ~p"/questions"

      assert_error_sent 404, fn ->
        get(conn, ~p"/questions/#{question}")
      end
    end
  end

  defp create_question(_) do
    question = question_fixture()

    %{question: question}
  end
end
