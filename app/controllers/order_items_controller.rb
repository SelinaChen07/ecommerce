class OrderItemsController < ApplicationController
	def create
		@order = current_order
		@product = Product.find(order_item_params[:product_id])
		
		#If the same product already exists in shopping cart, update the old order item.
		if @order_item = @order.order_items.find_by(product_id: order_item_params[:product_id])
			@product_quantity = @order_item.product_quantity + order_item_params[:product_quantity].to_i
			if @order_item.update(product_quantity: @product_quantity)
				succeed_add_shoppingcart
			else
				fail_add_shoppingcart				
	    	end
	    #Build a new order item
		else			
			@order_item = @order.order_items.build(order_item_params)
			@product_quantity = order_item_params[:product_quantity].to_i
	    	if @order_item.save
	    		succeed_add_shoppingcart
	    	else
				fail_add_shoppingcart
	    	end
	    end

	    respond_to do |format|
	    	format.html {
	    		if @msg_type == "success"
	    			flash[:success] = @msg
	    		elsif
	    			@msg_type == "danger"
	    			flash[:danger] = @msg
	    		end
	    		redirect_to @product
	    	}
	    	format.js
	    end
	end

	def update
		@order_item = OrderItem.find(params[:id])		
		@new_quantity = order_item_params[:product_quantity]
		if @order_item.update(product_quantity: @new_quantity)
			@msg = "Your product quantity is successfully updated."	
		end		
		
		respond_to do |format|
	    	format.html {
	    		flash[:success] = @msg	    		
	    		redirect_to shoppingcart_path
	    	}
	    	format.js
	    end
	end

	def destroy
		@order_item = OrderItem.find(params[:id])
		@order_item.destroy
		if current_order.item_quantity == 0
			current_order.delete
			session[:order_id] = nil
		end
		flash[:success] = "The product #{@order_item.product.title} is successfully removed."
		redirect_to shoppingcart_path

	end

	private
	def order_item_params
		params.require(:order_item).permit(:product_id, :product_quantity)
	end

	#If product successfully been added to shopping cart/current order.
	def succeed_add_shoppingcart
		@msg = "Your product is successfully added to the shopping cart."
		@msg_type = "success"
	end

	#If product fail to add to shopping cart/current order.
	def fail_add_shoppingcart
		stock = @product.stock
		@msg_type = "danger"
		@msg = "Sorry, the maximum ordering amount for each item is #{Rails.configuration.max_order_quantity}."
	end
end
