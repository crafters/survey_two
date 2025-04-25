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
      <section className='content-section'>
        <header>
          <div className='circle' />
          <div className='border-circle-medium' />
          <div className='border-circle-large' />
          <div className='survey-logo-container'>
            <img src='/images/LogoWhite.svg' alt='' />
          </div>
          <p>{survey.title}</p>
        </header>
        <div>
          <div className='content-box'>
            <h2>You're all done!</h2>
            <p>{survey.thanks_message || 'Thanks for sharing your thoughts! See you soon!'}</p>
            <div className='button-container' style={{ marginTop: '20px', display: 'flex', gap: '10px', justifyContent: 'center' }}></div>
          </div>

          <div className='navigation-controls navigation-controls-mobile'>
            <button onClick={() => setGoToFirstQuestion(true)} className='next-button'>
              See my answers
            </button>
            <button className='start-over-button' onClick={handleStartOver}>
              Start over
            </button>
          </div>
        </div>
      </section>
    </>
  );
};

export default ThankYouPage;
