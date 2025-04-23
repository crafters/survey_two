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
      <section className='welcome-section'>
        <header className='welcome-header'>
          <div className='circle' />
          <div className='border-circle-medium' />
          <div className='border-circle-large' />
          <h1 className='survey-header-title survey-header-title-welcome'>Omella</h1>
          <p className='survey-header-subtitle survey-header-subtitle-welcome'>User Experience Survey</p>
        </header>
        <div className='welcome-container'>
          <div className='welcome-content'>
            <h2>{survey?.title || 'Survey'}</h2>
            <p>{survey?.description || 'Survey description'}</p>
          </div>
          <div className='navigation-controls navigation-controls-welcome'>
            <button onClick={handleStartSurvey} className='nav-button next-button'>
              Start Survey
            </button>
          </div>
        </div>
      </section>
    </>
  );
};

export default WelcomePage;
