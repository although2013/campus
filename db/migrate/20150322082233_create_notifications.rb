class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user, index: true

      t.boolean :read, default: false
      t.string  :content
      t.integer :order_id

      t.timestamps null: false
    end
  end
end
