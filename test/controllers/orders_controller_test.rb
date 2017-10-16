require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  
	def setup
  	@product1 = products(:product1)
    @product2 = products(:product2)
  	@product3 = products(:product3)
  end
  
  test "should be ordered by created time" do

  	assert_difference 'OrderItem.count', 1 do
  		post order_items_path, params:{order_item:{product_id: @product1.id, product_quantity: 1}}
  	end

  	assert_difference 'OrderItem.count', 1 do
  		post order_items_path, params:{order_item:{product_id: @product2.id, product_quantity: 2}}
  	end

  	assert_difference 'OrderItem.count', 1 do
  		post order_items_path, params:{order_item:{product_id: @product3.id, product_quantity: 3}}
  	end

  	assert_no_difference 'OrderItem.count'do
  		patch order_item_path(OrderItem.last), params:{order_item:{product_id: @product1.id, product_quantity: 3}}
  	end

  	order_items = OrderItem.first(3)
  	for i in 0..1
  		assert order_items[i].created_at <= order_items[i+1].created_at
  	end

  end

end
