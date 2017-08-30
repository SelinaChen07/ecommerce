class Photo < ApplicationRecord
	belongs_to :product, inverse_of: :photos	
	mount_uploader :image, ImageUploader

end
