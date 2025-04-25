import React from 'react';
import { useLocation } from 'wouter';

const WelcomePage = ({ survey, slug, responseId }) => {
  const [_location, setLocation] = useLocation();

  const handleStartSurvey = () => {
    const queryString = responseId ? `?r=${responseId}` : '';
    setLocation(`/${slug}/1${queryString}`);
  };

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
          <p>User Experience Survey</p>
        </header>
        <div>
          <div className='content-box'>
            <h2>{survey?.title || 'Survey'}</h2>
            <p>{survey?.description || 'Survey description'}</p>
          </div>
          <div className='navigation-controls navigation-controls-mobile'>
            <button onClick={handleStartSurvey} className='next-button'>
              Start Survey
            </button>
          </div>
        </div>
      </section>
    </>
  );
};

export default WelcomePage;
