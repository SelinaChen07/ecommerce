class Order < ApplicationRecord
	attr_accessor :total
	has_many :order_items, :dependent => :destroy
end
