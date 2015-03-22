class ApplicationController < ActionController::Base
  before_action :set_locale
  protect_from_forgery with: :exception


  include ApplicationHelper
  include SessionsHelper
  include OrdersHelper
  include NotificationsHelper
  include UsersHelper





  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
