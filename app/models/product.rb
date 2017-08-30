class Product < ApplicationRecord
	has_many :photos, inverse_of: :product
	accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: proc{|attributes| attributes['image'].blank? && attributes['image_cache'].blank?}

	validates :title, presence: true, length:{maximum:255}
	validates :abstract, length:{maximum:255}
	validates :description, presence: true
	validates :price, numericality:{less_than: 1000000}
	validates :stock, numericality:{only_integer: true}


end
