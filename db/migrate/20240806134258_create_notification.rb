class CreateNotification < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.integer :task_id
      t.integer :task_user_id
      t.string :task_url
      t.integer :task_status, default: 0
      t.string :scraping_brand
      t.string :scraping_model
      t.decimal :scraping_price
      t.timestamps
    end
  end
end
