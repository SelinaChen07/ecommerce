class OrderItem < ApplicationRecord
	attr_accessor :subtotal, :product
	belongs_to :order
	belongs_to :product

	validates :product_quantity, :numericality => {:only_integer => true, :greater_than => 0}

	def product
		product = Product.find(self.product_id)
	end

	def subtotal
		price = self.product.price
		subtotal = self.product_quantity * price
	end

end
