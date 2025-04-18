import React from 'react';
import TextQuestion from './questions/TextQuestion';
import SingleChoiceQuestion from './questions/SingleChoiceQuestion';
import MultipleChoiceQuestion from './questions/MultipleChoiceQuestion';
import DropdownQuestion from './questions/DropdownQuestion';

const Question = ({ question, currentAnswer, onAnswerChange }) => {
  const renderQuestionByType = () => {
    switch (question.type) {
      case 'text':
        return <TextQuestion question={question} currentAnswer={currentAnswer} onAnswerChange={onAnswerChange} />;
      case 'single_choice':
        return <SingleChoiceQuestion question={question} currentAnswer={currentAnswer} onAnswerChange={onAnswerChange} />;
      case 'multiple_choice':
        return <MultipleChoiceQuestion question={question} currentAnswer={currentAnswer} onAnswerChange={onAnswerChange} />;
      case 'dropdown':
        return <DropdownQuestion question={question} currentAnswer={currentAnswer} onAnswerChange={onAnswerChange} />;
      default:
        return <TextQuestion question={question} currentAnswer={currentAnswer} onAnswerChange={onAnswerChange} />;
    }
  };

  return (
    <div className='question-container'>
      {renderQuestionByType()}
    </div>
  );
};

export default Question;
