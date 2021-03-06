class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include ApplicationHelper

  def check_cart
    if !order_exist?
      flash[:warning] = "Please add some items to your shopping cart before checkout."
      redirect_to root_path
    end
  end


  def check_stock
    if order_exist?
      @order_items = current_order.order_items
      @order_items.each do |order_item|
        if !order_item.enough_stock?
          flash[:danger] = "Sorry, one or more of the items in your shopping cart is not available. Please review your shopping cart."
          redirect_to shoppingcart_path
        end
      end
    end
  end

  def start_reserve
    if !current_order.valid_reserve?
      current_order.update(reserve_stock:true, reserve_until: Time.now + Rails.configuration.reserve_time)
    end
  end

  def check_shipping_address
  	if current_order.shipping_address.nil?
  		flash[:danger] = "Please fill in the shipping address before pay."
        redirect_to new_checkout_shipping_address_path
    end
  end

end
