class UsersController < ApplicationController
  before_action :set_user, only: [:show]


  def index
    @users = User.all
  end

  def show
    @orders = @user.orders.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_name(params[:name])
    end

end
