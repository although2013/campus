class OrdersController < ApplicationController
  before_action :signed_in_user, only: [:new, :show, :edit, :update]
  before_action :set_order, only: [:show, :edit, :update, :destroy]


  def index
    @orders = Order.includes(:user).where(['deadline > ? AND server IS NULL', Time.now])
    if current_user
      @my_servers = Order.where(:server => current_user.id).limit(5)
    end
  end

  def show
  end


  def new
    @order = Order.new
  end


  def edit
  end

  def get_order
    @order = Order.find(params[:order])
    if current_user && current_user == User.find(params[:user_id])
      if @order.server == nil
        @order.update_attribute(:server, current_user.id)
        Notification.create(user_id: @order.user_id, order_id: @order.id, content: "你的订单##{@order.id},被接单啦!")
        WebsocketRails[:orders].trigger 'order_gotten', @order.id
        respond_to do |format|
          format.html
          format.js
        end
      else
        respond_to do |format|
          format.json { render :json => { :error => '该订单已被他人获取' } }
        end
      end
    end
  end

  def cancel_order
    order = Order.find(params[:order])
    if current_user && current_user.id == order.server
      order.update_attribute(:server, nil)

      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    else
      respond_to do |format|
        format.json { render :json => { :error => '取消订单出错' } }
      end
    end
  end


  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      WebsocketRails[:orders].trigger 'new_order', current_user.name
      flash[:success] = "任务发布成功！"
      redirect_to @order
    else
      flash[:danger] = "任务发布失败！"
      render :new
    end
  end


  def update
    if @order.update_attributes(order_params)
      flash[:success] = "修改成功！"
      redirect_to @order
    else
      flash[:danger] = "修改失败！"
      render :edit
    end
  end



  def destroy
    if @order.user == current_user
      @order.destroy
      respond_to do |format|
        format.html { redirect_to orders_url, success: 'Order was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash[:danger] = "失败，不能删除他人任务！"
      render :show
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:title, :content, :deadline, :location, :phone, :status, :total, :server)
    end
    
end
