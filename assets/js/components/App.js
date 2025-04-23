import React from 'react';
import { Switch, Route } from 'wouter';
import Survey from './Survey';
import ErrorPage from './ErrorPage';
import ErrorBoundary from './ErrorBoundary';

function App() {
  return (
    <ErrorBoundary fallback={ErrorPage}>
      <Switch>
        <Route path='/:slug/:questionIndex' component={Survey} />
        <Route path='/:slug' component={Survey} />
      </Switch>
    </ErrorBoundary>
  );
}

export default App;
