# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

App Development Breakdown

1. Displaying Product
1.1 Model
1.1.1 products
   title: string
   abstract: string
   description: text
   price: decimal
   stock: integer

   has_many :photos, inverse_of: :product
   accepts_nested_attributes_for :photos

   has_many :categorizations, dependent: :destroy, inverse_of: :product
  has_many :categories, through: :categorizations
  accepts_nested_attributes_for :categorizations, :allow_destroy => true, reject_if: proc{|attributes| attributes['category_id'].blank?}
   
   has_many :order_items
   has_many :orders, through: :order_items
   

1.1.2 photos
  	product_id :integer
    image: string #use carrierwave uploader

    belongs_to :product, inverse_of: :photos

1.1.3 categorizations
	product_id: integer
	category_id: integer

	belongs_to :product, inverse_of: :categorizations
  belongs_to :category, inverse_of: :categorizations

1.1.4 categories
	name:string

	has_many :categorizations, dependent: :destroy, inverse_of: :category
  has_many :products, through: :categorizations


2. Orders
2.1 orders
  user_id: integer
  shipping_address_id: integer
  
  add_column :orders, :status, :string, default: unsubmitted
  (unsubmitted/placed/packing/in delivery/delivered/canceled)

  belongs_to :user
  has_many :order_items, dependent: :destroy
  belongs_to :shipping_address

  model method: 
  - subtotal(exclude delivery)
  - total(include delivery)
  - delivery_fee
  - item_quantity

  [Note]order.destroy, all order items deleted. Consider shipping addresses and payment.


2.2 order_items
  order_id :integer
  product_id :integer
  product_quantity :integer (validates >0)

  belongs_to :order
  belongs_to :product

  model method: 
  - subtotal
  - product
  - enough_stock? (true/false)
  - print_stock (In stock/Out of Stock/Insufficient Stock)

  [Note]: The order_items are always ordered by created_at::asc(default_scope)

2.3 shipping_addresses
  firstname: string
  lastname: string
  phone: string (optional)
  email: string
  level_or_suite (optional)
  street_address
  city: string (optional)
  state: string
  country: string(default: Australia)
  postcode: string (optional)
  user_id :integer

  has_many :orders
  belongs_to :user

2.3 Implementing an order flow
2.3.1  Link for adding a product to cart
  products#show:
  @order_item = OrderItem.new(product_quantity: 1)
  @order_item.product_id = @product.id

  products/show.html.erb:
        <%= form_for @order_item do |f| %>
          <%= f.select :product_quantity, options_for_select(1..12) %>
          <%= f.hidden_field :product_id %>
          <%= f.submit "Add to Shopping Cart" %>
        <% end %> 

2.3.2  order_items#create action
  1. get current_order by session[:order_id]
  2. if order_item already esists in current order, just add the product quantity;
  else @order_item = @order.order_items.build(order_item_params)
  flash[:success] and redirect to current showing product page

2.3.3 view shopping cart

  _header.html.erb:  <%= link_to shoppingcart_path %>
  [Note]: if user order_path(current_order) for the route of viewing shopping cart. Other users could input ".../orders/some_order_id" in brower's address to change other customer's order if the order is unsubmitted. Plus, we don't want the customer to see the order id. Thus, we add an non-restful route for viewing shopping cart: get '/shoppingcart' => 'orders#shoppingcart'.
  
  orders/show.html.erb:
  if order.item_quantity == 0
    "Shopping cart is empty"
  else
    - Table with item(image & product name), show stock level/quantity(ediable)/remove link, price, order_item.subtotal, order.subtotal,delivery_fee, total.
    - link for empty shopping cart => @order.destroy, session[:order_id]=nil
  end
  [Note]show stock status in shopping cart. Out of Stock/Insufficient Stock.

  To update product quantity:
  form_for order_item => order_items#update:
  [Note]Use options_for_select(1..12, f.object.product_quantity) to ensure valid input of product quantity.
  if product_quantity == "0" remove @order_item
  else
    @order_item.update()
    flash[:success]    
    redirect_to shoppingcart_path
  end

2.3.4 checkout
2.3.4.1 Checkout Button
  - non-restful route for checkout: get '/checkout' => 'orders#edit_order_shipping_address'
  - before_action :check_cart, only:[:edit_order_shipping_address] (If shopping cart is empty, can't checkout.)
  - before_action :check_stock, only:[:edit_order_shipping_address]
  (if !order_item.enough_stock?, flash.now[:danger], render "shoppingcart_page"; )

  [Note] If two customer order the same product the same time and only 1 in stock, they will both see in stock during checkout. To avoid the situation, stock -1 when customer click on checkout. And customer is allowed 20mins to finish the checkout.
    

2.3.4.1 Checkout - Fill in Shipping Address
  @shipping_address = @order.build_shipping_address

  form_for @order url:checkout_path
  f.submit "Next" : 
  patch '/checkout' => 'orders#update_order_shipping_address'  
  (show checkout summary at the sidebar)

  link for "log in to save time"

  (Shipping address could be created under 2 situations: 1st loggedin user, 2nd unloggedin user)
  if logged_in
  choose one of the saved address or create a new from drop-down options. Auto-fill the form if saved address is selected.  
  @shipping_address.user_id = current_user.id if current_user
  current_order.shipping_address_id = @shipping_address.id if current_order
  else
   creat a new
  end

  [Note] Shipping Address and Payment to decouple from order. Create several steps to finish checkout. Customer can go back to the previous step to review the fill in information. When clink on next, information is saved to backend.

2.3.4.2 Payment

2.3.4.3 Confirm Order
  patch '/confirm_order' => 'orders#confirm_order'
  if @order.update(checkout_params)
      session[:order_id] = nil
      @order.update(status: "placed")
      (default will render "orders#confirm_order")
  else
      render "checkout" 
  end


2.3.5 Order index for admin


 Filling address
  payment
  

2.3.5 Admin check orders and edit order status

3.Users

  has_many: shipping_addresses

Pending:

[Note]order.destroy, all order items deleted. Consider shipping addresses and payment.

[Note] If two customer order the same product the same time and only 1 in stock, they will both see in stock during checkout. To avoid the situation, stock -1 when customer click on checkout. And customer is allowed 20mins to finish the checkout.
current_order.destroy when close browser if shopping cart is empty?
if shopping cart is not empty, save for 1 month?

move current_order from ApplicationController and application_helper to session_helper

Admin Cancel transaction and Refund


Admin page useful link eg: uncategorized products
unsubmitted orders, delete in batch if it is 3 months old?
paginate form
_product_list_admin_view => _product_list (if admin stock: stock number else availability)
product show.html if admin show category and stock

current position, eg: for him > cards

order cupon
price original/special offer

customer email update


print price





