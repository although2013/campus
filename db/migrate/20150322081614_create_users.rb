class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.decimal :balance, default: 0.00, precision: 8, scale: 2
      t.string  :phone

      t.integer :current_orders, default: 0

      t.integer :score, default: 0
      t.integer :quantity, default: 0
      t.integer :wrong_count, default: 0
      t.integer :terminated_count, default: 0
    end
  end
end
