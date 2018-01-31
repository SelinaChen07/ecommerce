class Product < ApplicationRecord
	has_many :photos, inverse_of: :product
	accepts_nested_attributes_for :photos, :allow_destroy => true, reject_if: proc{|attributes| attributes['image'].blank? && attributes['image_cache'].blank?}

	has_many :categorizations, dependent: :destroy, inverse_of: :product
	has_many :categories, through: :categorizations
	accepts_nested_attributes_for :categorizations, :allow_destroy => true, reject_if: proc{|attributes| attributes['category_id'].blank?}

	validates :title, presence: true, length:{maximum:255}, uniqueness: true
	validates :abstract, length:{maximum:255}
	validates :description, presence: true
	validates :price, numericality:{less_than: 1000000, greater_than_or_equal_to:0 }
	validates :stock, numericality:{only_integer: true, greater_than_or_equal_to:0 }


end
