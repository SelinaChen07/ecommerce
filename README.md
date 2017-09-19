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
  
  add_column :orders, :status, :string, default: unsubmitted
  (unsubmitted/placed/packing/in delivery/delivered/canceled)

  belongs_to :user
  has_many :order_items, dependent: :destroy

  model method: 
  - subtotal(exclude delivery)
  - total(include delivery)
  - delivery_fee
  - item_quantity


2.2 order_items
  order_id :integer
  product_id :integer
  product_quantity :integer (validates >0)

  belongs_to :order
  belongs_to :product

  model method: 
  - subtotal
  - product

2.3 Implementing an order flow
2.3.1  Link for adding a product to cart
  products#show:
  @order_item = OrderItem.new(product_quantity: 1)
  @order_item.product_id = @product.id

  products/show.html.erb:
        <%= form_for @order_item do |f| %>
          <%= f.select :product_quantity, options_for_select(1..9) %>
          <%= f.hidden_field :product_id %>
          <%= f.submit "Add to Shopping Cart" %>
        <% end %> 

2.3.2  order_items#create action
  1. get current_order by session[:order_id]
  2. if order_item already esists in current order, just add the product quantity;
  else @order_item = @order.order_items.build(order_item_params)

  flash[:success] and redirect to current showing product page?

2.3.3 view shopping cart
  _header.html.erb:  
  -<%= link_to order_path(current_order) %>
  
  orders/show.html.erb:
  if order.item_quantity == 0
    "Shopping cart is empty"
  else
    - Table with item(image & product name), quantity(ediable)/remove link, price, order_item.subtotal, order.subtotal,delivery_fee, total.
    - link for empty shopping cart
    Note: The order_items are always ordered by created_at::asc
  end

  To update product quantity:
  form_for order_item => order_items#update:
  if product_quantity == "0" remove @order_item
  else
    @order_item.update()
    if success flash[:success]
    else flash[:danger] = "Product quantity should be positive integer."
    end
    redirect_to order_path(@order_item.order)
  end




  check stock, if order_item.product_quantity > product.stock, show warning


2.3.4 checkout
  before_checkout: check stock, order_item.product_quantity < product.stock
  Filling address
  payment
  session[:order_id]=nil

2.3.5 Admin check orders and edit order status

3.Users

move current_order from ApplicationController and application_helper to session_helper


Admin page useful link eg: uncategorized products
_product_list_admin_view => _product_list (if admin stock: stock number else availability)
product show.html if admin show category and stock

current position, eg: for him > cards

order cupon
price original/special offer



print price





