import '../css/base.css';

import { createRoot } from 'react-dom/client';
import React from 'react';
import App from './components/App';

document.addEventListener('DOMContentLoaded', () => {
  const reactRoot = document.getElementById('react-root');
  if (reactRoot) {
    const root = createRoot(reactRoot);
    root.render(<App />);
  }
});
