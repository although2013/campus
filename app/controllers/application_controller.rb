class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception


  include ApplicationHelper
  include OrdersHelper
  include NotificationsHelper
  include UsersHelper



  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
    end


    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

  private

    def after_sign_out_path_for(resource_or_scope)
      root_path
    end
end
