class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.string :password_digest
      t.string :remember_token

      t.decimal :balance, default: 0.00, precision: 8, scale: 2
      t.string  :phone

      t.integer :score, default: 10
      t.integer :quantity, default: 0
      t.integer :wrong_count, default: 0
      t.integer :terminated_count, default: 0

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_index :users, :name, unique: true
    add_index :users, :remember_token
  end
end
