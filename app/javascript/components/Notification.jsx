import React, { useEffect, useState } from 'react';
import { createConsumer } from '@rails/actioncable';

const Notification = ({ room, callback, errorCallback }) => {

  useEffect(() => {
    const cable = createConsumer('ws://localhost:3000/cable'); // Adjust URL as needed
    const subscription = cable.subscriptions.create(
      { channel: 'NotificationsChannel', room: room },
      {
        received(data) {
          console.log(data)
          if(data.message !== undefined) {
            errorCallback(data.message)
          }
          else {
            callback(data.board.data.attributes);
          }
          
        }
      }
    );

    return () => {
      subscription.unsubscribe();
    };
  }, [room, callback, errorCallback]);

  return (
    <></>
  );
};

export default Notification;