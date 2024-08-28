// app/javascript/components/App.js
import './Board.css'; // Import CSS for styling
import React, { useState, useEffect } from 'react';
import axios from 'axios';

const Board = ({boardId}) => {
  const [board, setBoard] = useState({});
  const [rows, setRows] = useState(0)
  const [cols, setCols] = useState(0)
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [grid, setGrid] = useState([[]]);
  
  const generateGrid = (rows, cols) => {
    return Array(rows).fill(null).map(() => Array(cols).fill(null))
  }

  const isAlive = (x, y) => {
    return !!board.coordinates.find(item => item.toString() == [x,y])
  }

  const setData = (data) => {
    setBoard(data);
    setRows(data.maxYCoords)
    setCols(data.maxXCoords)
    setGrid(generateGrid(data.maxYCoords, data.maxXCoords))
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
        setLoading(false);
      } catch (err) {
        setError('Error fetching board data');
        setLoading(false);
      }
    };

    fetchBoardData();
  }, [boardId]); // Fetch data when boardId changes


  if (loading) return <div>Loading...</div>;
  if (error) return <div>{error}</div>;

  return (
    <>
      <p>States Away: {board.statesAway}</p>
      <div className="grid-container" style={gridStyle}>
        {grid.map((row, rowIdx) => (
          <div key={rowIdx}>
            {row.map((cell, colIdx) => (
              <>
              {console.log(`Row: ${rowIdx} Col: ${colIdx}`)}
              <div
                key={colIdx}
                className={`grid-cell ${isAlive(rowIdx, colIdx) ? 'alive' : 'dead'}`}
              />
              </>
            ))}
            </div>
        ))}
      </div>
    </>
  );
};

export default Board;