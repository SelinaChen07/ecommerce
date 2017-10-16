require 'test_helper'

class PlaceOrderTest < ActionDispatch::IntegrationTest

  def setup
  	@product1 = products(:product1)
    @product2 = products(:product2) #out of stock
  	@product3 = products(:product3)
    @shipping_address = {firstname:"helen", lastname:"LI", phone:"0414987689", email:"Li@Gmail.com", level_or_suite:"apt 13", street_address:"19 East drive", suburb_or_city:"Ryde",state:"nsw", contry:"", postcode:"2112"}
  end

  test "shopping cart should be empty" do
    get shoppingcart_path
    assert_match "Your shopping cart is empty.", response.body
  end

  test "should place order" do  	
  	#should create a new order
  	assert_difference 'Order.count', 1 do
  		post order_items_path, params:{order_item:{product_id: @product1.id, product_quantity: 3}}
  	end

  	#should add new items to order
  	assert_no_difference 'Order.count' do
  		post order_items_path, params:{order_item:{product_id: @product3.id, product_quantity: 1}}
  	end

  	#should add the same item to order
  	assert_no_difference 'OrderItem.count' do
  		post order_items_path, params:{order_item:{product_id: @product3.id, product_quantity: 3}}
  	end
  	assert_equal OrderItem.last.product_quantity, 3+1

  	#should go to shopping cart
  	get shoppingcart_path
  	OrderItem.all.each do |order_item|
  		product = order_item.product
  		assert_match product.title, response.body
  		assert_match product.price.to_s, response.body
  		assert_match order_item.product_quantity.to_s, response.body
  	end
  	assert_select "form input[value=?]", "Update Quantity", count: OrderItem.count
  	assert_match Order.last.total.to_s, response.body
  	assert_select "a[href=?]", "/checkout/shipping_address/new", text:"Checkout", count:1
    assert_select "a", text:"1. Shopping Cart", count:0
    assert_select "a", text:"2. Delivery", count:0
    assert_select "a", text:"3. Payment", count:0
    

  	#should redirect to new_checkout_shipping_address_path
  	get edit_checkout_shipping_address_path
    assert_redirected_to new_checkout_shipping_address_path
    assert flash.empty?
    

    #should redirect to new address before pay
    get new_payment_path
    assert_redirected_to new_checkout_shipping_address_path
    assert_not flash.empty?
    

    #should create shipping address
    get new_checkout_shipping_address_path
    assert_select "a", text:"1. Shopping Cart", count:1
    assert_select "a", text:"2. Delivery", count:0
    assert_select "a", text:"3. Payment", count:0

    assert_difference "ShippingAddress.count", 1 do
      post checkout_shipping_address_path, params:{shipping_address:{firstname:@shipping_address[:firstname], lastname:@shipping_address[:lastname], phone:@shipping_address[:phone], email:@shipping_address[:email], level_or_suite:"", street_address:"18 North Street", suburb_or_city:@shipping_address[:suburb_or_city],state:@shipping_address[:state], country:"", postcode:@shipping_address[:postcode]}}
    end
    assert_redirected_to new_payment_path

    #should edit shipping address
    get edit_checkout_shipping_address_path
    assert_response :success
    assert_select "a", text:"1. Shopping Cart", count:1
    assert_select "a", text:"2. Delivery", count:0
    assert_select "a", text:"3. Payment", count:1
    assert_no_difference "ShippingAddress.count" do
      patch checkout_shipping_address_path, params:{shipping_address:{firstname:@shipping_address[:firstname], lastname:@shipping_address[:lastname], phone:@shipping_address[:phone], email:@shipping_address[:email], level_or_suite:@shipping_address[:level_or_suite], street_address:@shipping_address[:street_address], suburb_or_city:@shipping_address[:suburb_or_city],state:@shipping_address[:state], country:"", postcode:@shipping_address[:postcode]}}
    end
    assert_redirected_to new_payment_path

    #should pay
    follow_redirect!
    assert_select "a", text:"1. Shopping Cart", count:1
    assert_select "a[href=?]", "/checkout/shipping_address/new", text:"2. Delivery", count:0
    assert_select "a[href=?]", "/checkout/shipping_address/edit", text:"2. Delivery", count:1
    assert_select "a", text:"3. Payment", count:0
    assert_match "Order Summary", response.body
    OrderItem.all.each do |order_item|
      product = order_item.product
      assert_match product.title, response.body
      assert_match order_item.product_quantity.to_s, response.body
    end
    assert_match "Delivery Information", response.body
    assert_match @shipping_address[:firstname].capitalize, response.body
    assert_match @shipping_address[:lastname].capitalize, response.body
    assert_match @shipping_address[:phone], response.body
    assert_match @shipping_address[:email].downcase, response.body
    assert_match @shipping_address[:level_or_suite].capitalize, response.body
    assert_match @shipping_address[:street_address].split.map(&:capitalize).join(' '), response.body
    assert_match @shipping_address[:suburb_or_city].split.map(&:capitalize).join(' '), response.body
    assert_match @shipping_address[:state].upcase, response.body
    assert_match "AUSTRALIA", response.body
    assert_match @shipping_address[:postcode], response.body   
    
  end

  test "should be out of stock" do
    #product2 should be out of stock
    post order_items_path, params:{order_item:{product_id: @product2.id, product_quantity: 1}}
    assert_redirected_to product_path(@product2)
    
    get shoppingcart_path
    assert_match "Out of Stock", response.body

    get new_checkout_shipping_address_path
    assert_template "shoppingcarts/show"
    assert_not flash.empty?
  end

  test "should be insufficient stock" do
    #update product1's quantity, should be insufficient stock
    post order_items_path, params:{order_item:{product_id: @product1.id, product_quantity: 1}}
    get shoppingcart_path
    patch order_item_path(OrderItem.last), params:{order_item:{product_quantity:12}}
    assert_redirected_to shoppingcart_path
    follow_redirect!
    assert_match "Insufficient Stock", response.body
   

    get new_checkout_shipping_address_path
    assert_template "shoppingcarts/show"
    assert_not flash.empty?

    get edit_checkout_shipping_address_path
    assert_template "shoppingcarts/show"
    assert_not flash.empty?

    get new_payment_path
    assert_template "shoppingcarts/show"
    assert_not flash.empty?
  end

  test "order item should be removed when quantity is zero" do
    assert_difference "OrderItem.count", 1 do
      post order_items_path, params:{order_item:{product_id: @product1.id, product_quantity: 1}}
    end
    assert_difference "OrderItem.count", -1 do
      patch order_item_path(OrderItem.last), params:{order_item:{product_quantity:0}}
    end
  end

  test "order item should be removed when deleted" do
    #update product1's quantity, should be insufficient stock
    assert_difference "OrderItem.count", 1 do
      post order_items_path, params:{order_item:{product_id: @product1.id, product_quantity: 1}}
    end
    assert_equal Order.count, 1
    assert_difference "OrderItem.count", -1 do
      delete order_item_path(OrderItem.last)
    end
    assert_equal Order.count, 0
  end

  test "should not be able to checkout" do
    get new_checkout_shipping_address_path
    assert_redirected_to root_path
    assert_not flash.empty?
  end

  test "should not be able to edit address" do
    get edit_checkout_shipping_address_path
    assert_redirected_to root_path
    assert_not flash.empty?
  end

  test "should not be able to pay" do
    get new_payment_path
    assert_redirected_to root_path
    assert_not flash.empty?
  end


  
end

