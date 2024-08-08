# frozen_string_literal: true

require 'sneakers'

class SaveNotificationWorker
  include Sneakers::Worker

  from_queue 'notification.save', prefetch: 5, threads: 5

  def work(msg)
    msg = JSON.parse(msg).deep_symbolize_keys
    NotificationService.save(msg)
    ack!
  end
end
