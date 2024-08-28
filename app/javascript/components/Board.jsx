// app/javascript/components/App.js
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import Notification from './Notification'
import NextStateButton from './NextStateButton'
import './Board.css'; // Import CSS for styling

const Board = ({boardId}) => {
  const [board, setBoard] = useState({});
  const [rows, setRows] = useState(0)
  const [cols, setCols] = useState(0)
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [grid, setGrid] = useState([[]]);
  const [ buttonDisabled, setButtonDisabled ] = useState(false)
  
  const generateGrid = (rows, cols) => {
    return Array(rows).fill(null).map(() => Array(cols).fill(null))
  }

  const isAlive = (rowId,colId) => {
    
    return !!board.coordinates.find(item => item.toString() == [colId,rowId])
  }

  const setData = (data) => {
    setBoard(data);
    setRows(data.maxYCoords)
    setCols(data.maxXCoords)
    setGrid(generateGrid(data.maxYCoords, data.maxXCoords))
    setLoading(false);
    setButtonDisabled(false)
  }

  const gridStyle = {
    display: 'grid',
    gridTemplateColumns: `repeat(${cols + 1}, 30px)`,
    gridTemplateRows: `repeat(${rows + 1}, 30px)`,
    margin: '20px auto',
    maxWidth: `calc(30px * ${cols} + 1px * (${cols} - 1))`
  };

  useEffect(() => {
    const fetchBoardData = async () => {
      try {
        const response = await axios.get(`/api/boards/${boardId}`);
        if(response.data.isProcessing) return true
        setData(response.data.data.attributes)
      } catch (err) {
        setError('Error fetching board data');
        setLoading(false);
      }
    };

    fetchBoardData();
  }, [boardId]); // Fetch data when boardId changes


  if (loading) return <div>Loading...</div>;

  return (
    <>
      <Notification room={boardId} callback={setData} errorCallback={setError}/>
      <p>States Away: {board.statesAway}</p>
      {error && (
        <p>{error}</p>
      )}
      <div className="grid-container" style={gridStyle}>
        {grid.map((row, rowIdx) => (
          <div key={rowIdx}>
            {row.map((cell, colIdx) => (
              <div
                key={`${rowIdx}-${colIdx}`}
                className={`grid-cell ${isAlive(rowIdx, colIdx) ? 'alive' : 'dead'}`}
              />
            ))}
            </div>
        ))}
      </div>
      <NextStateButton boardId={boardId} isDisabled={buttonDisabled} setButtonDisabled={setButtonDisabled}/>
    </>
  );
};

export default Board;