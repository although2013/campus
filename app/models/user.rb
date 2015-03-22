class User < ActiveRecord::Base
  validates :name, uniqueness: { case_sensitive: false }, format: { with: /[a-zA-Z][a-zA-Z0-9]{3,19}/ }
  validates :email, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[a-z0-9-]+\.)+[a-z]{2,})\z/i }
  validates :password, length: { minimum: 6 }, :on => :create

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  has_secure_password

  has_many :orders, dependent: :destroy
  has_many :notifications, dependent: :destroy

  

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end




  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
