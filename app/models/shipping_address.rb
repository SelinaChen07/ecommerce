class ShippingAddress < ApplicationRecord
	has_many :orders, inverse_of: :shipping_address

	validates :firstname, :lastname, :street_address, :suburb_or_city, :state, :country, :postcode,  presence: true, length: {maximum: 255}
	
	VALID_PHONE_REGEX = /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/
	validates :phone, presence: true, length:{maximum: 30}#, format:{with: VALID_PHONE_REGEX}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates(:email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX})

	validates :level_or_suite, length: {maximum: 255}




end
