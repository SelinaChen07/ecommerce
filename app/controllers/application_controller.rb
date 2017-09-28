class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

 def order_exist?
    !!@order = Order.find_by(id: session[:order_id])
  end

 def current_order
	if !@order = Order.find_by(id: session[:order_id])
      		@order = Order.create
      		session[:order_id] = @order.id
    end
    return @order
 end

 def check_cart
    if !order_exist?
      flash[:warning] = "Please add some items to your shopping cart before checkout."
      redirect_to root_path
    end
  end


  def check_stock
    @order_items = @order.order_items
    @order_items.each do |order_item|
      if !order_item.enough_stock?
        flash.now[:danger] = "Sorry, one or more of the items in your shopping cart is not available. Please review your shopping cart."
        render "orders/shoppingcart"
      end
    end
  end

  def check_shipping_address
  	if @order.shipping_address.nil?
  		flash[:danger] = "Please fill in the shipping address before pay."
        redirect_to checkout_shipping_address_path
    end
  end

end
