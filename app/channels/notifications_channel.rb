class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_#{params['room']}"
    Rails.logger.info "Subscribed to room '#{params['room']}'" # Log subscription
  end

  def unsubscribed
    Rails.logger.info "Unsubscribed from room '#{params['room']}'" # Log unsubscription
  end
end
