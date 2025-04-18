import React, { useState, useEffect } from 'react';

const WelcomePage = ({ params }) => {
  const [survey, setSurvey] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchSurvey = async () => {
      try {
        const response = await fetch(`/api/surveys/${params.slug}`);
        const data = await response.json();
        setSurvey(data.survey);
      } catch (error) {
        console.error('Error fetching survey:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchSurvey();
  }, [params.slug]);

  const handleStartSurvey = () => {
    window.location.href = `/survey/${params.slug}/1`;
  };

  if (loading) return <div>Loading...</div>;

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
            <h2>{survey?.title || 'Survey'}</h2>
            <p>{survey?.description || 'Survey description'}</p>
          </div>
          <div className="navigation-controls navigation-controls-welcome">
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
