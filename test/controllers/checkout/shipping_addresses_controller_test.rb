require 'test_helper'

class Checkout::ShippingAddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get checkout_shipping_addresses_new_url
    assert_response :success
  end

  test "should get edit" do
    get checkout_shipping_addresses_edit_url
    assert_response :success
  end

end
