class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true

      t.string     :title
      t.text       :content
      t.integer    :deadline
      t.string     :location
      t.string     :phone
      t.string     :status

      t.timestamps null: false
    end
  end
end
