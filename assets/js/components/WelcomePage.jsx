import React from 'react';
import { Link } from 'wouter';

const WelcomePage = () => {
  const handleStartSurvey = () => {
    Link('/survey');
  };

  return (
    <>
      <section className="welcome-section">
        <header className="welcome-header">
          <div className="circle" />
          <div className="border-circle-medium" />
          <div className="border-circle-large" />
          <h1 className="survey-header-title survey-header-title-welcome">Omella</h1>
          <p className="survey-header-subtitle survey-header-subtitle-welcome">User Experience Survey</p>
        </header>
        <div className="welcome-container">
          <div className="welcome-content">
            <h2>We'd Love your feedback</h2>
            <p>Your feedback shapes our journey. It only takes a minute - start now!</p>
          </div>
          <div className="navigation-controls ">
            <button onClick={handleStartSurvey} className="nav-button next-button">
              Start Survey
            </button>
          </div>
        </div>
      </section>
    </>
  );
};

export default WelcomePage;
