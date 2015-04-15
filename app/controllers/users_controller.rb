class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_name(params[:name])
    if @user
      @orders = @user.orders.all
    end
  end

end
