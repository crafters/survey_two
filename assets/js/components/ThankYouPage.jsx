import React, { useState } from 'react';
import { Link, Redirect } from 'wouter';

const ThankYouPage = ({ slug }) => {
  const [redirect, setRedirect] = useState(false);

  const handleStartOver = async () => {
    try {
      const response = await fetch(`/api/surveys/${slug}/clear_session`, {
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
    window.location.href = `/survey/${slug}/1`;
  }

  return (
    <div className='thank-you-container'>
      <div className='thank-you-content'>
        <h1>Thank You!</h1>
        <p>Your survey responses have been submitted successfully.</p>
        <p>We appreciate your feedback and time.</p>
        <div className='button-container' style={{ marginTop: '20px', display: 'flex', gap: '10px', justifyContent: 'center' }}>
          <button onClick={() => setRedirect(true)} className='nav-button next-button'>
            See my answers
          </button>
          <button className='nav-button prev-button' onClick={handleStartOver}>
            Start over
          </button>
        </div>
      </div>
    </div>
  );
};

export default ThankYouPage;
