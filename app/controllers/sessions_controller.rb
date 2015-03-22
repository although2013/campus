class SessionsController < ApplicationController
  def new
    render 'new'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or orders_path
    else
      flash.now[:danger] = '你输入的邮箱地址或密码有误，请重试。'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to orders_path
  end
end
