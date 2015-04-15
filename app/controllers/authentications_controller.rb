class AuthenticationsController < ApplicationController
  def index
    @authentications = Authentication.all
  end

  def create
    #render :text => request.env["omniauth.auth"].to_yaml
    omniauth = request.env["omniauth.auth"]
    Rails.logger.info "--- #{omniauth['info']['name']} ---"
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create(provider: omniauth['provider'], uid: omniauth['uid'])
      falsh[:notice] = "Authentication successfull"
      redirect_to authentications_url
    else
      user = User.new
      user.authentications.build(provider:omniauth['provider'], uid:omniauth['uid'])
      if User.find_by_name(omniauth['info']['name'])
        user.name = Time.now.to_f.to_s[5,10]
      else
        user.name = omniauth['info']['name']
      end
      user.save(:validate => false)
      flash[:notice] = "Signed in Successfully"
      sign_in_and_redirect(:user, user)
    end
  end

  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
