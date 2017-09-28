class ShoppingcartsController < ApplicationController
  def show
  	if order_exist?
      @order = current_order
      @order_items = @order.order_items
    end
  end

  def destroy
  	order = current_order
    shipping_address = order.shipping_address
    if !shipping_address.nil?
      shipping_address.destroy if shipping_address.user_id.nil?
    end
  	order.destroy
    session[:order_id] = nil
  	flash[:success] = "You shopping cart is now empty. "
  	redirect_to root_path
  end

end
