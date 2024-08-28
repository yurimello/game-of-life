import React, { useState } from 'react';
import axiosInstance from '../utils/axiosInstance';

const FinalStateButton = ({boardId}) => {
  const [disabled, setDisabled] = useState(false)
  const travelToFinalState = async () => {
    setDisabled(true)
    try {
      const response = await axiosInstance.put(`/boards/${boardId}/final_states`);
      console.log(response)
    } catch (err) {
      console.log(err)
      setDisabled(false)
    }
  }

  return (
    <button style={{marginLeft: '10px'}} onClick={travelToFinalState} disabled={disabled}>Travel to Final State</button>
  )
}
export default FinalStateButton;