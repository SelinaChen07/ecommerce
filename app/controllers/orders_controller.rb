class OrdersController < ApplicationController
  before_action :check_stock, only:[:checkout]

  def index
  end

  def show
  
  end

  def update

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
    @order_items = @order.order_items
  end

  def checkout
    #@order = current_order #already get the value from check_stock
    @shipping_address = @order.build_shipping_address
  end

  def confirm_order
    @order = current_order
    if @order.update(checkout_params)
      session[:order_id] = nil
      @order.update(status: "placed")
    else
      render "checkout" 
    end
  end

  private
  def checkout_params
    params.require(:order).permit(shipping_address_attributes:[:id, :firstname, :lastname, :phone, :email, :level_or_suite, :street_address, :city, :state, :contry, :postcode] )
  end

  def check_stock
    @order = current_order
    @order_items = @order.order_items
    @order_items.each do |order_item|
      if !order_item.enough_stock?
        flash.now[:danger] = "Sorry, one or more of the items in your shopping cart is not available. Please review your shopping cart."
        render "shoppingcart"
      end
    end
  end

end
