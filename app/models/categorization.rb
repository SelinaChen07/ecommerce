class Categorization < ApplicationRecord
	belongs_to :product, inverse_of: :categorizations
	belongs_to :category, inverse_of: :categorizations

	validates :product_id, uniqueness: {scope: :category_id, message:"already has the same category."}
end
