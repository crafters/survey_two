import React from 'react';
import { Switch, Route, Link } from 'wouter';
import Survey from './Survey';
import WelcomePage from './WelcomePage';
import ErrorBoundary from './ErrorBoundary';
import ErrorPage from './ErrorPage';

function App() {
  return (
    <ErrorBoundary fallback={ErrorPage}>
      <Switch>
        <Route path='/survey/:slug' component={WelcomePage} />
        <Route path='/survey/:slug/:questionIndex?' component={Survey} />
      </Switch>
    </ErrorBoundary>
  );
}

export default App;
