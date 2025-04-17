import React from 'react';
import { Switch, Route, Link } from 'wouter';
import Survey from './Survey';

function App() {
  return (
    <main>
      <Switch>
        <Route path='/survey/:slug/:questionIndex?' component={Survey} />
        <Route>
          <Link to='/survey/slug'>Survey</Link>
        </Route>
      </Switch>
    </main>
  );
}

export default App;
