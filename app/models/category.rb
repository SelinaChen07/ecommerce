class Category < ApplicationRecord
	has_many :categorizations
	has_many :products, through: :categorizations

	validates :name, presence: true, length:{maximum:255}, uniqueness:{case_sensitive: false}
end
