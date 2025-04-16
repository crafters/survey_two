defmodule SurveyTwo.SurveysTest do
  use SurveyTwo.DataCase

  alias SurveyTwo.Surveys

  describe "surveys" do
    alias SurveyTwo.Surveys.Survey

    import SurveyTwo.SurveysFixtures

    @invalid_attrs %{active: nil, description: nil, title: nil, slug: nil}

    test "list_surveys/0 returns all surveys" do
      survey = survey_fixture()
      assert Surveys.list_surveys() == [survey]
    end

    test "get_survey!/1 returns the survey with given id" do
      survey = survey_fixture()
      assert Surveys.get_survey!(survey.id) == survey
    end

    test "create_survey/1 with valid data creates a survey" do
      valid_attrs = %{active: true, description: "some description", title: "some title", slug: "some slug"}

      assert {:ok, %Survey{} = survey} = Surveys.create_survey(valid_attrs)
      assert survey.active == true
      assert survey.description == "some description"
      assert survey.title == "some title"
      assert survey.slug == "some slug"
    end

    test "create_survey/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Surveys.create_survey(@invalid_attrs)
    end

    test "update_survey/2 with valid data updates the survey" do
      survey = survey_fixture()
      update_attrs = %{active: false, description: "some updated description", title: "some updated title", slug: "some updated slug"}

      assert {:ok, %Survey{} = survey} = Surveys.update_survey(survey, update_attrs)
      assert survey.active == false
      assert survey.description == "some updated description"
      assert survey.title == "some updated title"
      assert survey.slug == "some updated slug"
    end

    test "update_survey/2 with invalid data returns error changeset" do
      survey = survey_fixture()
      assert {:error, %Ecto.Changeset{}} = Surveys.update_survey(survey, @invalid_attrs)
      assert survey == Surveys.get_survey!(survey.id)
    end

    test "delete_survey/1 deletes the survey" do
      survey = survey_fixture()
      assert {:ok, %Survey{}} = Surveys.delete_survey(survey)
      assert_raise Ecto.NoResultsError, fn -> Surveys.get_survey!(survey.id) end
    end

    test "change_survey/1 returns a survey changeset" do
      survey = survey_fixture()
      assert %Ecto.Changeset{} = Surveys.change_survey(survey)
    end
  end

  describe "questions" do
    alias SurveyTwo.Surveys.Question

    import SurveyTwo.SurveysFixtures

    @invalid_attrs %{position: nil, type: nil, options: nil, text: nil, required: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Surveys.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Surveys.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{position: 42, type: "some type", options: ["option1", "option2"], text: "some text", required: true}

      assert {:ok, %Question{} = question} = Surveys.create_question(valid_attrs)
      assert question.position == 42
      assert question.type == "some type"
      assert question.options == ["option1", "option2"]
      assert question.text == "some text"
      assert question.required == true
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Surveys.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{position: 43, type: "some updated type", options: ["option1"], text: "some updated text", required: false}

      assert {:ok, %Question{} = question} = Surveys.update_question(question, update_attrs)
      assert question.position == 43
      assert question.type == "some updated type"
      assert question.options == ["option1"]
      assert question.text == "some updated text"
      assert question.required == false
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Surveys.update_question(question, @invalid_attrs)
      assert question == Surveys.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Surveys.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Surveys.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Surveys.change_question(question)
    end
  end

  describe "responses" do
    alias SurveyTwo.Surveys.Response

    import SurveyTwo.SurveysFixtures

    @invalid_attrs %{respondent_id: nil}

    test "list_responses/0 returns all responses" do
      response = response_fixture()
      assert Surveys.list_responses() == [response]
    end

    test "get_response!/1 returns the response with given id" do
      response = response_fixture()
      assert Surveys.get_response!(response.id) == response
    end

    test "create_response/1 with valid data creates a response" do
      valid_attrs = %{respondent_id: "some respondent_id"}

      assert {:ok, %Response{} = response} = Surveys.create_response(valid_attrs)
      assert response.respondent_id == "some respondent_id"
    end

    test "create_response/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Surveys.create_response(@invalid_attrs)
    end

    test "update_response/2 with valid data updates the response" do
      response = response_fixture()
      update_attrs = %{respondent_id: "some updated respondent_id"}

      assert {:ok, %Response{} = response} = Surveys.update_response(response, update_attrs)
      assert response.respondent_id == "some updated respondent_id"
    end

    test "update_response/2 with invalid data returns error changeset" do
      response = response_fixture()
      assert {:error, %Ecto.Changeset{}} = Surveys.update_response(response, @invalid_attrs)
      assert response == Surveys.get_response!(response.id)
    end

    test "delete_response/1 deletes the response" do
      response = response_fixture()
      assert {:ok, %Response{}} = Surveys.delete_response(response)
      assert_raise Ecto.NoResultsError, fn -> Surveys.get_response!(response.id) end
    end

    test "change_response/1 returns a response changeset" do
      response = response_fixture()
      assert %Ecto.Changeset{} = Surveys.change_response(response)
    end
  end

  describe "answers" do
    alias SurveyTwo.Surveys.Answer

    import SurveyTwo.SurveysFixtures

    @invalid_attrs %{value: nil}

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Surveys.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Surveys.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      valid_attrs = %{value: "some value"}

      assert {:ok, %Answer{} = answer} = Surveys.create_answer(valid_attrs)
      assert answer.value == "some value"
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Surveys.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      update_attrs = %{value: "some updated value"}

      assert {:ok, %Answer{} = answer} = Surveys.update_answer(answer, update_attrs)
      assert answer.value == "some updated value"
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Surveys.update_answer(answer, @invalid_attrs)
      assert answer == Surveys.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Surveys.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Surveys.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Surveys.change_answer(answer)
    end
  end
end
