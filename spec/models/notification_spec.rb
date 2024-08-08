# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:task_url) }
    it { should validate_presence_of(:task_user_id) }
  end

  describe 'callbacks' do
    let(:notification) { build(:notification) }

    it 'calls notification_callback after create' do
      # Permite que qualquer instância de NotificationCallbackEvent receba o método publish!
      allow_any_instance_of(NotificationCallbackEvent).to receive(:publish!)

      # Salva a notificação, o que deve acionar o callback
      expect(notification).to receive(:notification_callback)
      notification.save
    end
  end
end