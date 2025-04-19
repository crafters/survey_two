import React, { useState, useEffect, useRef } from 'react';

const PhoneQuestion = ({ question, currentAnswer, onAnswerChange }) => {
  const [answer, setAnswer] = useState(currentAnswer || '');
  const [isValid, setIsValid] = useState(true);
  const debounceTimerRef = useRef(null);

  useEffect(() => {
    if (currentAnswer !== undefined) {
      setAnswer(currentAnswer);
      const valid = validatePhone(currentAnswer);
      setIsValid(valid);
    }

    return () => {
      if (debounceTimerRef.current) {
        clearTimeout(debounceTimerRef.current);
      }
    };
  }, [currentAnswer]);

  const validatePhone = (phone) => {
    if (!phone) {
      return true;
    }

    const cleanPhone = phone.replace(/\D/g, '');

    const usPhoneRegex = /^1?\d{10}$/;
    const brPhoneRegex = /^(?:55)?(?:0?[1-9]{2})(?:9?\d{8})$/;

    return usPhoneRegex.test(cleanPhone) || brPhoneRegex.test(cleanPhone);
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
    const valid = validatePhone(value);
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
      <input type='tel' className={`email-input ${!isValid ? 'invalid' : ''}`} value={answer} onChange={handleChange} onBlur={handleBlur} />
      {!isValid && <div className='validation-error'>Please enter a valid phone number</div>}
    </div>
  );
};

export default PhoneQuestion;
