# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    task_url { "http://example.com" }
    task_user_id { 1 }
    task_id { 100_000 }
    task_status { :pending }
    scraping_brand { nil }
    scraping_model { nil }
    scraping_price { nil }
  end
end