class OrdersController < ApplicationController
  before_action :check_cart, only:[:edit_order_shipping_address]
  before_action :check_stock, only:[:edit_order_shipping_address]
  
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

  def edit_order_shipping_address
    #@order = current_order #already get the value from check_stock
    @shipping_address = @order.build_shipping_address
  end

  def update_order_shipping_address
    @order = current_order
    if @order.update(checkout_shipping_address_params)
      redirect_to new_payment_path
    else
      render "edit_order_shipping_address" 
    end
  end

  def payment
    
  end

  def confirm_order
    
  end

  private
  def checkout_shipping_address_params
    params.require(:order).permit(shipping_address_attributes:[:id, :firstname, :lastname, :phone, :email, :level_or_suite, :street_address, :city, :state, :contry, :postcode] )
  end

end
