class Product < ApplicationRecord
	has_many :photos, inverse_of: :product
	accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: proc{|attributes| attributes.image.File.nil?}
end
