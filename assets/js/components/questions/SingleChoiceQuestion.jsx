import React, { useState, useEffect } from 'react';

const SingleChoiceQuestion = ({ question, currentAnswer, onAnswerChange }) => {
  const [selectedOption, setSelectedOption] = useState(currentAnswer || '');

  useEffect(() => {
    if (currentAnswer !== undefined) {
      setSelectedOption(currentAnswer);
    }
  }, [currentAnswer]);

  const handleChange = (option) => {
    setSelectedOption(option);
    if (onAnswerChange) {
      onAnswerChange(option);
    }
  };

  return (
    <div>
      <h2>{question.position}. {question.title}</h2>
      <div className='options-list'>
        {question.options &&
          question.options.map((option, index) => (
            <div key={index} className='option-item'>
              <input 
                type='checkbox' 
                id={`option-${question.id}-${index}`} 
                name={`question-${question.id}`} 
                value={option} 
                checked={selectedOption === option}
                onChange={() => handleChange(option)}
              />
              <label htmlFor={`option-${question.id}-${index}`}>{option}</label>
            </div>
          ))}
      </div>
    </div>
  );
};

export default SingleChoiceQuestion;
