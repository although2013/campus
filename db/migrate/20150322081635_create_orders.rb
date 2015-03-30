class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true

      t.string     :title
      t.text       :content
      t.datetime   :deadline
      t.string     :location
      t.string     :phone
      t.string     :status
      t.integer    :server
      t.decimal    :total, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
