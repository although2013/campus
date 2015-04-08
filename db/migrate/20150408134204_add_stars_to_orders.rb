class AddStarsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :stars, :integer
  end
end
