class OrdersController < ApplicationController
  before_action :signed_in_user, only: [:new, :show, :edit, :update, :finished_order, :wrong_order, :do_star, :get_order, :pending_order, :cancel_order]
  before_action :set_order, only: [:show, :edit, :update, :destroy]



  def index
    @orders = Order.includes(:user).where(['deadline > ? AND server IS NULL', Time.now])
    if current_user
      @my_servers = Order.where(['server = ? AND status = "serving"', current_user.name]).limit(5)
    end
  end

  def show
    @server = User.find_by_name(@order.server) if !@order.server.blank?
  end


  def new
    @order = Order.new
  end


  def edit
  end

  def search
    if params[:search]
      @orders = Order.where(["(deadline > ? AND server IS NULL) AND \
(title LIKE ? OR content LIKE ? OR location LIKE ?)",
                                Time.now,
                                "%#{params[:search]}%",
                                "%#{params[:search]}%",
                                "%#{params[:search]}%"])
      render :index
    else
      redirect_to orders_path
    end
  end

  def finished_order
    @order = Order.find(params[:id])
    if current_user.id == params[:user_id].to_i && @order.user == current_user && @order.status == "pending"
      @order.status = "finished"
      process = order_process(@order, current_user)
      @order.update_attributes(:status => @order.status, :process => process)
      respond_to do |format|
        format.js
      end
    else
      render :json => {:error => 'something wrong...'}
    end
  end

  def wrong_order
    
  end

  def pending_order
    @order = Order.find(params[:id])
    if @order.status == "serving"
      @order.status = "pending"
      if current_user && current_user.name == @order.server
        process = order_process(@order, current_user)
        @order.update_attributes(:status => @order.status, :process => process)
        Notification.create(user_id: @order.user_id, order_id: @order.id, content: "你的订单##{@order.id},被接单员确认已完成!")
        respond_to do |format|
          format.js
        end
      end
    end
  end

  def do_star
    @order = Order.includes(:user).find(params[:id])
    if @order.user == current_user && (["pending","finished","wrong"].include? @order.status)
      @order.update_attribute(:stars, params[:star])
      server = User.find_by_name(@order.server)
      server.update_attribute(:score, (server.score * (server.quantity-1) + 2 * (params[:star]).to_i)/(server.quantity))
      render :json => {}
    else
      render :json => {:error => '订单未完成或非本人订单,无法评分'}
    end
  end

  def get_order
    @order = Order.find(params[:id])
    @order.status = "serving"
    if current_user && current_user == User.find(params[:user_id])
      if @order.deadline < Time.now
        respond_to do |format|
          format.json { render :json => { :error => '该订单已过期，无法接单' } }
        end
      elsif @order.server == nil
        process = order_process(@order, current_user)
        @order.update_attributes(:server => current_user.name, :status => @order.status, :process => process)
        current_user.update_attribute(:quantity, (current_user.quantity + 1))
        Notification.create(user_id: @order.user_id, order_id: @order.id, content: "你的订单##{@order.id},被接单啦!")
        WebsocketRails[:orders].trigger 'order_gotten', @order.id
        respond_to do |format|
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
    @order = Order.find(params[:id])
    @order.status = "terminated"
    process = order_process(@order, current_user)
    if current_user && current_user.name == @order.server
      @order.update_attributes(:server => nil, :status => @order.status, :process => process)
      current_user.update_attribute(:terminated_count, (current_user.terminated_count + 1))
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
    @order.status = "waiting"
    @order.process = order_process(@order, current_user)
    if @order.save
      current_user.update_attribute(:phone, @order.phone)
      flash[:success] = "任务发布成功！"
      redirect_to @order
      WebsocketRails[:orders].trigger 'new_order', current_user.name
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
      params.require(:order).permit(:title, :content, :deadline, :location, :phone, :total)
    end
end
