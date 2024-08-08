# frozen_string_literal: true

class NotificationService
  class << self
    def save(msg)
      notification = Notification.where(task_id: msg[:id]).first_or_initialize
      notification.task_user_id = msg[:user_id]
      notification.task_url = msg[:url]
      notification.task_status = msg[:status]
      notification.save
    end

    def update(msg)
      notification = Notification.find_by(task_id: msg[:task_id])
      notification.update(scraping_brand: msg[:brand], scraping_model: msg[:kind],
                          scraping_price: msg[:price], task_status: msg[:completed] ? 'done' : 'error' )
       NotificationCallbackEvent.new(notification.event_attributes).publish!
    end
  end
end
