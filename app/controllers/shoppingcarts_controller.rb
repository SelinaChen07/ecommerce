class ShoppingcartsController < ApplicationController
  def show
  	if order_exist?
      @order = current_order
      @order_items = @order.order_items
    end
  end

  def destroy
  	order = current_order
    order.delete
  	flash[:success] = "You shopping cart is now empty. "
  	redirect_to root_path
  end

end
