import React, { useEffect, useState } from 'react';
import { createConsumer } from '@rails/actioncable';

const Notification = ({ room, callback }) => {

  useEffect(() => {
    const cable = createConsumer('ws://localhost:3000/cable'); // Adjust URL as needed
    const subscription = cable.subscriptions.create(
      { channel: 'NotificationsChannel', room: room },
      {
        received(message) {
          // Update component state with new data
          callback(message.board.data.attributes);
        }
      }
    );

    return () => {
      subscription.unsubscribe();
    };
  }, [room, callback]);

  return (
    <></>
  );
};

export default Notification;