class OrdersController < ApplicationController
  def index
  end

  def show
  	@order = Order.find(params[:id])
  	@order_items = @order.order_items.order(created_at: :asc)
  end

  def destroy
  	@order = Order.find(params[:id])
  	@order.destroy
  	flash[:success] = "You shopping cart is now empty. "
  	redirect_to root_path
  end
end
