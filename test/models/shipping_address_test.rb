require 'test_helper'

class ShippingAddressTest < ActiveSupport::TestCase

	def setup
		@shipping_address = {firstname:"helen", lastname:"LI", phone:"0414987689", email:"Li@Gmail.com", level_or_suite:"apt 13", street_address:"19 East drive", suburb_or_city:"Ryde",state:"nsw", postcode:"2112"}
	end
  
    test "firstname should be present" do
  		add = ShippingAddress.new(firstname:"", lastname:@shipping_address[:lastname], phone:@shipping_address[:phone], email:@shipping_address[:email], level_or_suite:"", street_address:@shipping_address[:street_address], suburb_or_city:@shipping_address[:suburb_or_city],state:@shipping_address[:state], postcode:@shipping_address[:postcode])
  		assert_not add.valid?
    end

    test "firstname should not be too long" do
    	add = ShippingAddress.new(firstname:"a"*256, lastname:@shipping_address[:lastname], phone:@shipping_address[:phone], email:@shipping_address[:email], level_or_suite:"", street_address:@shipping_address[:street_address], suburb_or_city:@shipping_address[:suburb_or_city],state:@shipping_address[:state], postcode:@shipping_address[:postcode])
  		assert_not add.valid?
    end

    test "email validation should reject invalid addresses" do
	    invalid_emails = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
	    invalid_emails.each do |invalid_email|
	      add = ShippingAddress.new(firstname:"a"*256, lastname:@shipping_address[:lastname], phone:@shipping_address[:phone], email:invalid_email, level_or_suite:"", street_address:@shipping_address[:street_address], suburb_or_city:@shipping_address[:suburb_or_city],state:@shipping_address[:state], postcode:@shipping_address[:postcode])
  			assert_not add.valid?
	    end
    end

    test "phone validation should reject invalid phone number" do
	    invalid_phones = %w[04145678901 +21409902098 bob (412)0987657]
	    invalid_phones.each do |invalid_phone|
	      add = ShippingAddress.new(firstname:"a"*256, lastname:@shipping_address[:lastname], phone:invalid_phone, email:@shipping_address[:email], level_or_suite:"", street_address:@shipping_address[:street_address], suburb_or_city:@shipping_address[:suburb_or_city],state:@shipping_address[:state], postcode:@shipping_address[:postcode])
  			assert_not add.valid?
	    end
    end

    test "should be valid" do
  		add = ShippingAddress.new(firstname:@shipping_address[:firstname], lastname:@shipping_address[:lastname], phone:@shipping_address[:phone], email:@shipping_address[:email], level_or_suite:"", street_address:@shipping_address[:street_address], suburb_or_city:@shipping_address[:suburb_or_city],state:@shipping_address[:state], postcode:@shipping_address[:postcode])
  		assert add.valid?
    end

end
