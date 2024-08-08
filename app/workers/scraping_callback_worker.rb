# frozen_string_literal: true

require 'sneakers'

class ScrapingCallbackWorker
  include Sneakers::Worker

  from_queue 'scraping.callback', prefetch: 5, threads: 5

  def work(msg)
    msg = JSON.parse(msg).deep_symbolize_keys
    NotificationService.update(msg)
    ack!
  end
end
