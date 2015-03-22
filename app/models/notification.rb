class Notification < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  scope :unread, -> { where(read: false) }
  scope :has_read, -> { where(read: true) }
end
