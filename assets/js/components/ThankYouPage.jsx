import React, { useState } from 'react';
import { Link, Redirect } from 'wouter';

const ThankYouPage = ({ slug, survey }) => {
  const [redirect, setRedirect] = useState(false);
  const [goToFirstQuestion, setGoToFirstQuestion] = useState(false);

  const handleStartOver = async () => {
    try {
      const response = await fetch(`/api/surveys/${survey.id}/clear_session`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      if (response.ok) {
        setRedirect(true);
      } else {
        console.error('Failed to clear session:', await response.text());
      }
    } catch (error) {
      console.error('Error clearing session:', error);
    }
  };

  if (redirect) {
    window.location.href = `/${slug}`;
  }

  if (goToFirstQuestion && survey.questions && survey.questions.length > 0) {
    window.location.href = `/${slug}/1`;
  }

  return (
    <>
      <section className='thank-you-section'>
        <header className='thank-you-header'>
          <div className='circle' />
          <div className='border-circle-medium' />
          <div className='border-circle-large' />
          <h1 className='survey-header-title survey-header-title-thank-you'>Omella</h1>
          <p className='survey-header-subtitle survey-header-subtitle-thank-you'>{survey.title}</p>
        </header>
        <div className='thank-you-container'>
          <div className='thank-you-content'>
            <h2>You're all done!</h2>
            <p>{survey.thanks_message || 'Thanks for sharing your thoughts! See you soon!'}</p>
            <div className='button-container' style={{ marginTop: '20px', display: 'flex', gap: '10px', justifyContent: 'center' }}></div>
          </div>

          <div className='navigation-controls navigation-controls-thank-you'>
            <button onClick={() => setGoToFirstQuestion(true)} className='nav-button next-button'>
              See my answers
            </button>
            <button className='nav-button prev-button' onClick={handleStartOver}>
              Start over
            </button>
          </div>
        </div>
      </section>
    </>
  );
};

export default ThankYouPage;
