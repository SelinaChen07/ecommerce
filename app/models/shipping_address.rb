class ShippingAddress < ApplicationRecord
	has_many :orders, inverse_of: :shipping_address

	validates :firstname, :lastname, :street_address, :suburb_or_city, :state, :country, :postcode,  presence: true, length: {maximum: 255}
	
	# Validate australian phone number. Supported formats: 0411 234 567, +61411 234 567, (02) 3892 1111, 38921111, 3892 111, 02 3892 1111.
	VALID_PHONE_REGEX = /\A\({0,1}((0|\+61)(2|4|3|7|8)){0,1}\){0,1}(\ |-){0,1}[0-9]{2}(\ |-){0,1}[0-9]{2}(\ |-){0,1}[0-9]{1}(\ |-){0,1}[0-9]{3}\z/;
	validates :phone, presence: true, length:{maximum: 30}, format:{with: VALID_PHONE_REGEX}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates(:email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX})

	validates :level_or_suite, length: {maximum: 255}

	before_save{
		self.firstname.capitalize!
		self.lastname.capitalize!
		self.phone.downcase!
		self.email.downcase!
		self.level_or_suite = level_or_suite.split.map(&:capitalize).join(' ') if !self.level_or_suite.empty?
		self.street_address = street_address.split.map(&:capitalize).join(' ')
		self.suburb_or_city = suburb_or_city.split.map(&:capitalize).join(' ')
		self.state.upcase!
		self.country.upcase!
	}
		

end
