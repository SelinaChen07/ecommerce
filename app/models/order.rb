class Order < ApplicationRecord
	
	has_many :order_items, :dependent => :destroy
	belongs_to :shipping_address, inverse_of: :orders, optional: true
	
	def subtotal
		subtotal = 0
		self.order_items.each{|order_item|
			subtotal += order_item.subtotal
		}
		return subtotal
	end

	def delivery_fee
		if self.subtotal > 100
			return 0.00
		else
			return 10.00
		end
	end

	def total
		total = self.subtotal + self.delivery_fee
	end

	def item_quantity
		item_quantity = 0
		self.order_items.each{|order_item|
			item_quantity += order_item.product_quantity
		}
		return item_quantity
	end
end
