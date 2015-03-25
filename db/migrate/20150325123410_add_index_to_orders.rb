class AddIndexToOrders < ActiveRecord::Migration
  def change
    add_index :orders, :title
    add_index :orders, :deadline
    add_index :orders, :location
    add_index :orders, :phone
    add_index :orders, :status
    add_index :orders, :server
    add_index :orders, :total
  end
end
