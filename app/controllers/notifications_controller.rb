class NotificationsController < ApplicationController
  before_action :authenticate_user!

  after_action :mark_all_as_read, only: [:index]

  def index
    @notifications =  current_user.notifications.all
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new notification_params
  end


  private
  def mark_all_as_read
    current_user.notifications.unread.update_all(read: true, updated_at: Time.now.utc)
  end

  def notification_params
    params.require(:notification).permit(:user_id, :content)
  end
end
