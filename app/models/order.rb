class Order < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }

  validates :user_id,     presence: true

  validates :title,        length: { minimum: 2 }
  validates :content,      length: { in: 3..300 }
  validates :phone,        format: { with: /1[0-9]{10}/ }
  validates :deadline,     format: { with: /[0-9]/ }
  validates :location,     length: { in: 1..80 }
  validates :total,        format: { with: /[0-9]+\.?[0-9]{0,2}/ }
end
