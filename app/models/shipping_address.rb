class ShippingAddress < ApplicationRecord
	has_many :orders, inverse_of: :shipping_address

	validates :firstname, :lastname, :street_address, :suburb_or_city, :state, :country, :postcode,  presence:{:message => "Please complete this field to continue."}
	validates :firstname, :lastname, :email, :level_or_suite, :street_address, :suburb_or_city, :state, :country, :postcode,  length: {maximum: 255, :message => "Maximum 255 charaters allowed."}
	
	# Validate australian phone number. Supported formats: 0411 234 567, +61411 234 567, (02) 3892 1111, 38921111, 3892 111, 02 3892 1111.
	VALID_PHONE_REGEX = /\A\({0,1}((0|\+61)(2|4|3|7|8)){0,1}\){0,1}(\ |-){0,1}[0-9]{2}(\ |-){0,1}[0-9]{2}(\ |-){0,1}[0-9]{1}(\ |-){0,1}[0-9]{3}\z/;
	validates :phone, presence:{:message => "Please complete this field to continue."}
	validates :phone, format:{with: VALID_PHONE_REGEX, message:"Please enter a valid phone number."}, :allow_blank => true

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence:{:message => "Please complete this field to continue."}
	validates :email, format:{with: VALID_EMAIL_REGEX, message:"Please enter a valid email address."}, :allow_blank=> true

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
