import React, { useEffect, useState, useRef } from 'react';
import { useLocation } from 'wouter';
import Question from './Question';
import ThankYouPage from './ThankYouPage';

const Survey = ({ params }) => {
  const { slug, questionIndex } = params;
  const [survey, setSurvey] = useState(null);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [answers, setAnswers] = useState({});
  const [isCompleted, setIsCompleted] = useState(false);
  const [validationError, setValidationError] = useState('');
  const [_location, setLocation] = useLocation();
  const debounceTimer = useRef(null);

  useEffect(() => {
    const fetchSurvey = async () => {
      const response = await fetch(`/api/surveys/${slug}`);
      const data = await response.json();
      setSurvey(data.survey);

      if (data.survey.response?.answers) {
        const answersObj = data.survey.response.answers.reduce((acc, answer) => {
          // Try to parse JSON strings for multiple choice answers
          let value = answer.value;
          try {
            // Check if the value is a JSON string representing an array
            if (typeof value === 'string' && value.startsWith('[') && value.endsWith(']')) {
              const parsedValue = JSON.parse(value);
              if (Array.isArray(parsedValue)) {
                value = parsedValue;
              }
            }
          } catch (e) {
            // If parsing fails, keep the original value
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

  if (!survey) {
    return <div>Loading...</div>;
  }

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
      const allAnswers = Object.entries(answersToSave).map(([qId, value]) => ({
        question_id: qId,
        value: value,
      }));

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
    setLocation(`/survey/${slug}/${index + 1}`);
  };

  const currentQuestion = survey.questions[currentQuestionIndex];
  const isFirstQuestion = currentQuestionIndex === 0;
  const isLastQuestion = currentQuestionIndex === survey.questions.length - 1;

  if (isCompleted) {
    return <ThankYouPage slug={slug} />;
  }

  return (
    <>
      <header className='survey-header'>
        <h1>{survey.title}</h1>
        <p>
          {survey.description} - {survey.response?.id || 'No response'}
        </p>
      </header>
      <section className='question-section'>
        <div className='question-progress'>
          Question {currentQuestionIndex + 1} of {survey.questions.length}
        </div>
        <Question
          key={currentQuestion.id}
          question={currentQuestion}
          currentAnswer={answers[currentQuestion.id]}
          onAnswerChange={(answer) => handleAnswerChange(currentQuestion.id, answer)}
        />
        {validationError && <div className='validation-error'>{validationError}</div>}
        <div className='navigation-controls'>
          <button className='nav-button prev-button' onClick={handlePrevious} disabled={isFirstQuestion}>
            Previous
          </button>
          <button className='nav-button next-button' onClick={handleNext}>
            {isLastQuestion ? 'Finish' : 'Next'}
          </button>
        </div>
      </section>
    </>
  );
};

export default Survey;
