import React, { useState, useEffect } from 'react';

const MultipleChoiceQuestion = ({ question, currentAnswer, onAnswerChange }) => {
  const [selectedOptions, setSelectedOptions] = useState(currentAnswer || []);

  useEffect(() => {
    if (currentAnswer !== undefined) {
      setSelectedOptions(currentAnswer);
    }
  }, [currentAnswer]);

  const handleChange = (option, isChecked) => {
    let newSelectedOptions;
    if (isChecked) {
      newSelectedOptions = [...selectedOptions, option];
    } else {
      newSelectedOptions = selectedOptions.filter((item) => item !== option);
    }

    setSelectedOptions(newSelectedOptions);
    if (onAnswerChange) {
      onAnswerChange(newSelectedOptions);
    }
  };

  return (
    <div>
      <h2>
        {question.position}. {question.title}
      </h2>
      {question.required && <div className="required-indicator">* Required</div>}
      <div className="options-list">
        {question.options &&
          question.options.map((option, index) => {
            const isChecked = selectedOptions.includes(option);
            return (
              <div key={index} className="option-item">
                <input
                  type="checkbox"
                  id={`option-${question.id}-${index}`}
                  name={`question-${question.id}`}
                  value={option}
                  checked={isChecked}
                  onChange={(e) => handleChange(option, e.target.checked)}
                />
                <label htmlFor={`option-${question.id}-${index}`}>{option}</label>
              </div>
            );
          })}
      </div>
    </div>
  );
};

export default MultipleChoiceQuestion;
