import React from 'react';

const ErrorPage = ({ error }) => {
  return (
    <section>
      <h1>Oops!</h1>
      <p>Something went wrong:</p>
      <span>{error.message}</span>
      <p>
        Contact support <a href='mailto:contact@crafters.cc'>here</a>.
      </p>
    </section>
  );
};

export default ErrorPage;
