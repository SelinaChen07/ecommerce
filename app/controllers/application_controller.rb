class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

 def current_order
	if !@order = Order.find_by(id: session[:order_id])
      		@order = Order.create
      		session[:order_id] = @order.id
    end
    return @order
end

end
