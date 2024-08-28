// app/javascript/components/App.js
import React from 'react';
import Board from './Board'

const App = () => {
  const boardId = window.location.pathname.split('/').pop()
  
  return <Board boardId={boardId} />
};

export default App;