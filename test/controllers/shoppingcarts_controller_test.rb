require 'test_helper'

class ShoppingcartsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get shoppingcarts_show_url
    assert_response :success
  end

end
