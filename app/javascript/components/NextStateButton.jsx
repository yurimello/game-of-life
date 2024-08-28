import React from 'react';
import axiosInstance from '../utils/axiosInstance';

const NextStateButton = ({boardId, isDisabled, setButtonDisabled}) => {

  const generateNextState = async () => {
    setButtonDisabled(true)
    try {
      const response = await axiosInstance.put(`/boards/${boardId}`);
      console.log(response)
    } catch (err) {
      console.log(err)
      setButtonDisabled(false)
    }
  }

  return (
    <button onClick={generateNextState} disabled={isDisabled}>Next State</button>
  )
}
export default NextStateButton;