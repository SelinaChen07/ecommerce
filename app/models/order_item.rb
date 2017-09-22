class OrderItem < ApplicationRecord
	
	belongs_to :order
	belongs_to :product

	validates :product_quantity, :numericality => {:only_integer => true, :greater_than => 0}

	default_scope -> {order(created_at: :asc)}

	def product
		product = Product.find_by(id: self.product_id)
	end

	def subtotal
		price = self.product.price
		subtotal = self.product_quantity * price
	end

	def enough_stock?
		self.product_quantity <= self.product.stock
	end

	def print_stock
		if self.product.stock == 0
			return "Out of Stock"
		elsif	self.product_quantity > self.product.stock
			return "Insufficient Stock"
		else
			return "In Stock"
		end
	end

end
