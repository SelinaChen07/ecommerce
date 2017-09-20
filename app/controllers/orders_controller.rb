class OrdersController < ApplicationController
  def index
  end

  def show
  
  end

  def destroy
  	@order = Order.find(params[:id])
  	@order.destroy
    session[:order_id] = nil
  	flash[:success] = "You shopping cart is now empty. "
  	redirect_to root_path
  end

  def shoppingcart
    @order = current_order
    @order_items = @order.order_items.order(created_at: :asc)
  end
end
