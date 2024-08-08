# frozen_string_literal: true

class Notification < ApplicationRecord
  validates :task_url, :task_user_id, presence: true
  enum task_status: [:pending, :in_progress, :done, :error]
  after_create :notification_callback

  def event_attributes
    { task_id: task_id, task_status: task_status, scraping_brand: scraping_brand,
      scraping_model: scraping_model, scraping_price: scraping_price, updated_at: updated_at }
  end

  private

  def notification_callback
    NotificationCallbackEvent.new(event_attributes).publish!
  end
end
