import React, { useState, useEffect } from 'react';

const TextQuestion = ({ question, currentAnswer, onAnswerChange }) => {
  const [answer, setAnswer] = useState(currentAnswer || '');

  useEffect(() => {
    if (currentAnswer !== undefined) {
      setAnswer(currentAnswer);
    }
  }, [currentAnswer]);

  const handleChange = (e) => {
    const value = e.target.value;
    setAnswer(value);
    if (onAnswerChange) {
      onAnswerChange(value);
    }
  };

  return (
    <div>
      <h2>{question.title}</h2>
      <p>{question.description || question.text}</p>
      <input type='text' className='text-input' value={answer} onChange={handleChange} />
    </div>
  );
};

export default TextQuestion;
