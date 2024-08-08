# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationCallbackEvent, type: :event do
  describe '#publish!' do
    subject { described_class.new(payload) }
    let(:notification) { build(:notification) }
    let(:payload) do
      {
        task_id: notification.task_id, task_status: notification.task_status,
        scraping_brand: notification.scraping_brand,scraping_model: notification.scraping_model,
        scraping_price: notification.scraping_price, updated_at: notification.updated_at
      }
    end

    before do
      allow(PublisherService).to receive(:publish)
    end

    it 'return queue name' do
      subject.publish!
      expect(subject.queue_name).to include('notification.callback')
    end
  end
end
