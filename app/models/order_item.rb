class OrderItem < ApplicationRecord
	attr_accessor :subtotal
	belongs_to :order
	belongs_to :product

	validates :product_quantity, :numericality => {:only_integer => true, :greater_than => 0}

end
