import React, { useEffect, useState } from 'react';
import { createConsumer } from '@rails/actioncable';

const Notification = ({ room }) => {
  const [notifications, setNotifications] = useState([]);

  useEffect(() => {
    const cable = createConsumer('ws://localhost:3000/cable'); // Adjust URL as needed
    const subscription = cable.subscriptions.create(
      { channel: 'NotificationsChannel', room: room },
      {
        received(data) {
          // Update component state with new data
          setNotifications(data);
        }
      }
    );

    return () => {
      subscription.unsubscribe();
    };
  }, [room]);

  return (
    <>{console.log(notifications)}</>
  );
};

export default Notification;