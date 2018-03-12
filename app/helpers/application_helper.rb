module ApplicationHelper
#	include SessionsHelper
	def order_exist?
		if !@current_order
			@current_order = Order.find_by(id: session[:order_id])
		end
		return !!@current_order
	end

	def current_order
		#if @current_order already exists, don't need to search for database again. Eg. order_exist? was run before.
		if !@current_order
		 @current_order = Order.find_by(id: session[:order_id])
	      	if !@current_order
	      		@current_order = Order.create
	      		session[:order_id] = @current_order.id
	      	end
	    end
	    return @current_order
 	end
end
