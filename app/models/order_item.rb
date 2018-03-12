class OrderItem < ApplicationRecord
	
	belongs_to :order
	belongs_to :product

	validates :product_quantity, :numericality => {:only_integer => true, :greater_than => 0, :less_than_or_equal_to => Rails.configuration.max_order_quantity }

	default_scope -> {order(created_at: :asc)}

	def subtotal
		price = self.product.price
		subtotal = self.product_quantity * price
	end

	
	def available_stock
		reserve_number = 0
		#take away the reserve number taken by other customers
		self.product.order_items.each do |order_item|
			if self.id != order_item.id && order_item.order.valid_reserve?
				reserve_number+=order_item.product_quantity
			end
		end
		return self.product.stock - reserve_number
	end
	
	#check if enough stock, considering the reserved stock by other customer
	def enough_stock?
		if self.product.stock == 0
			return false
		else
			return self.product_quantity <= available_stock
		end
		#self.product_quantity <= self.product.stock
	end

	def stock_alert
		if self.product.stock == 0
			return "Out of Stock"
		elsif !enough_stock?
			return "Only #{available_stock} available"			
		end
	end

end
