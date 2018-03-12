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

	def delete
		shipping_address = self.shipping_address
	    if !shipping_address.nil?
	      shipping_address.destroy if shipping_address.user_id.nil?
	    end
	  	self.destroy
	end

	#To see if the order is reserved and still within valid timeframe?
	def valid_reserve?
		if self.reserve_stock
			if Time.now <= self.reserve_until
				return true
			else
				#change reserve_stock to false to skip checkup this order next time
				self.update(reserve_stock: false)
			end
		end
		return false
	end


end

  