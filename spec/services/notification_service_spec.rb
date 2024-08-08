# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationService, type: :service do
  let(:event_double) { instance_double(NotificationCallbackEvent, publish!: true) }
  describe '.save' do
    let(:msg) { { id: 1, user_id: 1, url: 'http://example.com', status: 'pending' } }
    context 'when the notification does not exist' do
      it 'creates a new notification with the given attributes' do
        expect {
          NotificationService.save(msg)
        }.to change(Notification, :count).by(1)

        notification = Notification.find_by(task_id: msg[:id])
        expect(notification.task_user_id).to eq(msg[:user_id])
        expect(notification.task_url).to eq(msg[:url])
        expect(notification.task_status).to eq(msg[:status])
      end
    end

    context 'when the notification already exists' do
      let!(:existing_notification) { create(:notification, task_id: msg[:id]) }

      it 'updates the existing notification with the given attributes' do
        expect {
          NotificationService.save(msg)
        }.not_to change(Notification, :count)

        existing_notification.reload
        expect(existing_notification.task_user_id).to eq(msg[:user_id])
        expect(existing_notification.task_url).to eq(msg[:url])
        expect(existing_notification.task_status).to eq(msg[:status])
      end
    end
  end

  describe '.update' do
    let(:msg) { { task_id: 1, brand: 'Brand', kimd: 'Model', price: 100.0, completed: true } }
    let!(:notification) { create(:notification, task_id: msg[:task_id]) }

    it 'updates the notification with the given attributes' do
      expect(NotificationCallbackEvent).to receive(:new).and_return(event_double)
      NotificationService.update(msg)
      notification.reload
      expect(notification.task_status).to eq('done')
      expect(notification.scraping_brand).to eq(msg[:brand])
      expect(notification.scraping_model).to eq(msg[:kind])
      expect(notification.scraping_price).to eq(msg[:price])
      expect(event_double).to have_received(:publish!)
    end

    it 'does not create a new notification' do
      expect {
        NotificationService.update(msg)
      }.not_to change(Notification, :count)
    end
  end
end