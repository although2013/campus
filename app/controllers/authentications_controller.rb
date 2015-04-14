class AuthenticationsController < ApplicationController
  def index
    @authentications = Authentication.all
  end

  def create
    render :text => request.env["rack.auth"].to_yaml

  end

  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end