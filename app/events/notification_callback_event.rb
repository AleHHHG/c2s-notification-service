# frozen_string_literal: true

class NotificationCallbackEvent < BaseEvent
  QUEUE_NAME = 'notification.callback'

  def initialize(payload)
    @queue_name = QUEUE_NAME
    @payload = payload
  end
end
