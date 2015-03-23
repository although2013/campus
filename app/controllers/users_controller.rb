class UsersController < ApplicationController
  before_action :signed_in_user, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :edit_avatar, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]



  def index
    @users = User.all
  end

  def show
  end


  def new
    @user = User.new
  end


  def edit
  end


  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      if params[:user][:avatar].present?
        render :edit_avatar
      else
        flash[:success] = "注册成功！"
        redirect_to @user
      end
    else
      render :new
    end
  end


  def update

    if @user.update_attributes(user_params)
      if params[:user][:avatar].present?
        render :edit_avatar
      else
        flash[:success] = "修改成功！"
        redirect_to @user
      end
    else
      flash[:danger] = "修改失败！"
      render :edit
    end
  end





  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, success: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def signed_in_user
      redirect_to new_session_path, danger: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
