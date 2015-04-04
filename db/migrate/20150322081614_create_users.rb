class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.string :password_digest
      t.string :remember_token

      t.integer :score, default: 100
      t.integer :quantity, default: 0


      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_index :users, :name, unique: true
    add_index :users, :remember_token
  end
end
