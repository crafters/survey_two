import React, { useState, useEffect } from 'react';

const DropdownQuestion = ({ question, currentAnswer, onAnswerChange }) => {
  const [selectedOption, setSelectedOption] = useState(currentAnswer || '');

  useEffect(() => {
    if (currentAnswer !== undefined) {
      setSelectedOption(currentAnswer);
    }
  }, [currentAnswer]);

  const handleChange = (e) => {
    const value = e.target.value;
    setSelectedOption(value);
    if (onAnswerChange) {
      onAnswerChange(value);
    }
  };

  return (
    <div>
      <h2>{question.position}. {question.title}</h2>
      <select 
        className="dropdown-select"
        value={selectedOption}
        onChange={handleChange}
      >
        <option value="">Select an option</option>
        {question.options && question.options.map((option, index) => (
          <option key={index} value={option}>{option}</option>
        ))}
      </select>
    </div>
  );
};

export default DropdownQuestion;
