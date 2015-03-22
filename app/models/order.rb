class Order < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }

  validates :title,     presence: true,   length: { minimum: 2 }
  validates :content,   presence: true,   length: { in: 3..300 }
  validates :phone,     uniqueness: true, format: { with: /1[0-9]{10}/ }
  validates :deadline,  presence: true,   format: { with: /[0-9]/ }
  validates :location,  presence: true,   length: { in: 1..80 }
end
