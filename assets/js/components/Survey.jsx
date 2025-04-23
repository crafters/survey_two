import React, { useEffect, useState, useRef } from 'react';
import { useLocation, useSearchParams } from 'wouter';
import Question from './Question';
import ThankYouPage from './ThankYouPage';
import WelcomePage from './WelcomePage';

const Survey = ({ params }) => {
  const { slug, questionIndex } = params;
  const [survey, setSurvey] = useState(null);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [answers, setAnswers] = useState({});
  const [isCompleted, setIsCompleted] = useState(false);
  const [validationError, setValidationError] = useState('');
  const [_location, setLocation] = useLocation();
  const [queryParams, setQueryParams] = useSearchParams();
  const debounceTimer = useRef(null);

  useEffect(() => {
    const fetchSurvey = async () => {
      const responseId = queryParams.get('r');

      const url = responseId ? `/api/surveys/${slug}?response_id=${responseId}` : `/api/surveys/${slug}`;

      const apiResponse = await fetch(url);
      const data = await apiResponse.json();

      setSurvey(data.survey);
      setQueryParams({ ...queryParams, r: data.survey?.response?.id });

      if (data.survey.response?.answers) {
        const answersObj = data.survey.response.answers.reduce((acc, answer) => {
          let value = answer.value;
          try {
            if (typeof value === 'string' && value.startsWith('[') && value.endsWith(']')) {
              const parsedValue = JSON.parse(value);
              if (Array.isArray(parsedValue)) {
                value = parsedValue;
              }
            }
          } catch (e) {
            console.error('Failed to parse answer value:', e);
          }

          acc[answer.question_id] = value;
          return acc;
        }, {});
        setAnswers(answersObj);
      }

      if (questionIndex && data.survey) {
        const parsedIndex = parseInt(questionIndex, 10) - 1;
        if (!isNaN(parsedIndex) && parsedIndex >= 0 && parsedIndex < data.survey.questions.length) {
          setCurrentQuestionIndex(parsedIndex);
        }
      }
    };

    fetchSurvey();
  }, [slug, questionIndex]);

  useEffect(() => {
    return () => {
      if (debounceTimer.current) {
        clearTimeout(debounceTimer.current);
      }
    };
  }, []);

  const handlePrevious = () => {
    if (currentQuestionIndex > 0) {
      setValidationError('');
      const newIndex = currentQuestionIndex - 1;
      setCurrentQuestionIndex(newIndex);
      updateUrlWithQuestionIndex(newIndex);
    }
  };

  const handleNext = () => {
    const currentQuestion = survey.questions[currentQuestionIndex];

    if (currentQuestion.required && !hasAnswer(currentQuestion.id)) {
      setValidationError('This question is required. Please provide an answer before proceeding.');
      return;
    }

    setValidationError('');

    if (currentQuestionIndex < survey.questions.length - 1) {
      const newIndex = currentQuestionIndex + 1;
      setCurrentQuestionIndex(newIndex);
      updateUrlWithQuestionIndex(newIndex);
    } else {
      submitSurvey();
    }
  };

  const hasAnswer = (questionId) => {
    const answer = answers[questionId];
    if (answer === undefined || answer === null) return false;
    if (typeof answer === 'string' && answer.trim() === '') return false;
    if (Array.isArray(answer) && answer.length === 0) return false;

    return true;
  };

  const submitSurvey = async () => {
    try {
      if (survey?.response?.id) {
        await saveAnswersToAPI(answers);
      }

      setIsCompleted(true);
    } catch (error) {
      console.error('Error submitting survey:', error);
    }
  };

  const saveAnswersToAPI = async (answersToSave) => {
    if (!survey?.response?.id) return;

    try {
      const allAnswers = Object.entries(answersToSave).map(([qId, value]) => {
        const question = survey.questions.find((q) => q.id === qId);
        return {
          question_id: qId,
          value: value,
          question_title: question?.title,
        };
      });

      const response = await fetch(`/api/responses/${survey.response.id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          response: {
            answers: allAnswers,
          },
        }),
      });

      if (!response.ok) {
        console.error('Failed to save answers:', await response.text());
      }
    } catch (error) {
      console.error('Error saving answers:', error);
    }
  };

  const debounce = (func, delay) => {
    if (debounceTimer.current) {
      clearTimeout(debounceTimer.current);
    }

    debounceTimer.current = setTimeout(func, delay);
  };

  const handleAnswerChange = (questionId, answer) => {
    const updatedAnswers = { ...answers, [questionId]: answer };
    setAnswers(updatedAnswers);

    if (!survey?.response?.id) return;

    const currentQuestion = survey.questions.find((q) => q.id === questionId);
    if (!currentQuestion) return;

    if (currentQuestion.type === 'text' || currentQuestion.type === 'multiple_choice') {
      debounce(() => saveAnswersToAPI(updatedAnswers), 700);
    } else {
      console.log('Saving answer:', { questionId, answer });
      saveAnswersToAPI(updatedAnswers);
    }
  };

  const updateUrlWithQuestionIndex = (index) => {
    const responseId = queryParams?.response_id;
    const queryString = responseId ? `?r=${responseId}` : '';
    setLocation(`/${slug}/${index + 1}${queryString}`);
  };

  if (!survey) {
    return <div>Loading...</div>;
  }

  if (questionIndex === undefined) {
    return <WelcomePage survey={survey} slug={slug} responseId={queryParams?.response_id} />;
  }

  if (isCompleted) {
    return <ThankYouPage slug={slug} survey={survey} />;
  }

  const currentQuestion = survey.questions[currentQuestionIndex];
  const isFirstQuestion = currentQuestionIndex === 0;
  const isLastQuestion = currentQuestionIndex === survey.questions.length - 1;

  return (
    <>
      <header>
        <img src='/images/Logotype_omela.svg' alt='' />
      </header>
      <section className='question-section'>
        <header className='survey-header'>
          <h1 className='survey-header-subtitle'>{survey.title}</h1>
        </header>
        <div className='question-container'>
          <Question
            key={currentQuestion.id}
            question={currentQuestion}
            currentAnswer={answers[currentQuestion.id]}
            onAnswerChange={(answer) => handleAnswerChange(currentQuestion.id, answer)}
          />

          <div className='progress-container'>
            {validationError && <div className='validation-error'>{validationError}</div>}
            <div className='navigation-controls'>
              <button className='nav-button prev-button' onClick={handlePrevious} disabled={isFirstQuestion}>
                Previous
              </button>
              <button className='nav-button next-button' onClick={handleNext}>
                {isLastQuestion ? 'Finish' : 'Next'}
              </button>
            </div>
            <div className='question-progress'>
              Step {currentQuestionIndex + 1} of {survey.questions.length}
            </div>
            <div className='progress-bar-wrapper'>
              <div className='progress-bar-fill' style={{ width: `${((currentQuestionIndex + 1) / survey.questions.length) * 100}%` }} />
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default Survey;
