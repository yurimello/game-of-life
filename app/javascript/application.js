import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './components/App';

document.addEventListener('DOMContentLoaded', () => {
  // Find the root element
  const rootElement = document.getElementById('root');
  
  if (rootElement) {
    // Create a root
    const root = createRoot(rootElement);
    
    // Render the App component into the root
    root.render(<App />);
  }
});