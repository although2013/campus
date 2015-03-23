class OrdersController < ApplicationController
  before_action :signed_in_user, only: [:new, :show, :edit, :update]
  before_action :set_order, only: [:show, :edit, :update, :destroy]


  def index
    @orders = Order.all
  end

  def show
  end


  def new
    @order = Order.new
  end


  def edit
  end


  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      flash[:success] = "任务发布成功！"
      redirect_to @order
    else
      flash[:danger] = "任务发布失败！"
      render :new
    end
  end


  def update
    if params["order"].length == 1 && params["order"]["server"] = ""
      if @order.server == nil
        @order.update_attribute(:server, current_user.id)
          respond_to do |format|
          format.html { }
          format.js
        end
      end
      
    else
      if @order.update_attributes(order_params)
        flash[:success] = "修改成功！"
        redirect_to @order
      else
        flash[:danger] = "修改失败！"
        render :edit
      end
    end
  end



  def destroy
    if @order.user == current_user
      @order.destroy
      respond_to do |format|
        format.html { redirect_to orders_url, success: 'User was successfully destroyed.' }
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
      params.require(:order).permit(:title, :content, :deadline, :location, :phone, :status, :total)
    end
    
end
