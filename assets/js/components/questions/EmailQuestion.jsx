import React, { useState, useEffect, useRef } from 'react';

const EmailQuestion = ({ question, currentAnswer, onAnswerChange }) => {
  const [answer, setAnswer] = useState(currentAnswer || '');
  const [isValid, setIsValid] = useState(true);
  const debounceTimerRef = useRef(null);

  useEffect(() => {
    if (currentAnswer !== undefined) {
      setAnswer(currentAnswer);
      const valid = validateEmail(currentAnswer);
      setIsValid(valid);
    }

    return () => {
      if (debounceTimerRef.current) {
        clearTimeout(debounceTimerRef.current);
      }
    };
  }, [currentAnswer]);

  const validateEmail = (email) => {
    if (!email) {
      return true;
    }

    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return emailRegex.test(email);
  };

  const handleChange = (e) => {
    const value = e.target.value;
    setAnswer(value);

    if (debounceTimerRef.current) {
      clearTimeout(debounceTimerRef.current);
    }

    debounceTimerRef.current = setTimeout(() => {
      saveIfValid(value);
    }, 500);
  };

  const saveIfValid = (value) => {
    const valid = validateEmail(value);
    setIsValid(valid);
    if (valid && currentAnswer !== value && onAnswerChange) {
      onAnswerChange(value);
    }
  };

  const handleBlur = () => {
    if (debounceTimerRef.current) {
      clearTimeout(debounceTimerRef.current);
    }
    saveIfValid(answer);
  };

  return (
    <div>
      <h2>
        {question.position}. {question.title}
      </h2>
      {question.required && <div className='required-indicator'>* Required</div>}
      <input type='email' className={`email-input ${!isValid ? 'invalid' : ''}`} value={answer} onChange={handleChange} onBlur={handleBlur} />
      {!isValid && <div className='validation-error'>Please enter a valid email address</div>}
    </div>
  );
};

export default EmailQuestion;
