class User < ActiveRecord::Base

  validates :name, uniqueness: { case_sensitive: false }, format: { with: /[a-zA-Z0-9]{3,19}/ }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



  has_many :orders, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :authentications, dependent: :destroy


  def to_param
    name
  end

end
