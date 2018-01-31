class OrderItemsController < ApplicationController
	def create
		@order = current_order
		@product = Product.find(order_item_params[:product_id])
		
		if @order_item = @order.order_items.find_by(product_id: order_item_params[:product_id])
			product_quantity = @order_item.product_quantity + order_item_params[:product_quantity].to_i
			if @order_item.update(product_quantity: product_quantity)
			@msg = "Your product is successfully added to the shopping cart."	    		
	    	end
		else			
			@order_item = @order.order_items.build(order_item_params)
	    	if @order_item.save
	    		@msg = "Your product is successfully added to the shopping cart."
	    	end
	    end

	    respond_to do |format|
	    	format.html {
	    		flash[:success] = @msg
	    		redirect_to @product
	    	}
	    	format.js


	    end
	end

	def update
		@order_item = OrderItem.find(params[:id])		
		new_quantity = order_item_params[:product_quantity]
		if new_quantity == "0"
			@order_item.destroy
			if current_order.item_quantity == 0
				current_order.delete
				session[:order_id] = nil
			end
			flash[:success] = "The product #{@order_item.product.title} is successfully removed."
		else
	  		@order_item.update(product_quantity: new_quantity)
			flash[:success] = "Your product quantity is successfully updated."	
		end
		redirect_to shoppingcart_path
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

	def order_item_params
		params.require(:order_item).permit(:product_id, :product_quantity)
	end
end
