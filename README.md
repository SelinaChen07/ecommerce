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

  model method: total

2.2 order_items
  order_id :integer
  product_id :integer
  product_quantity :integer (validates >0)

  belongs_to :order
  belongs_to :product

  model method: subtotal

2.3 Implementing an order flow
2.3.1  Link for adding a product to cart
  Under product_path(@product) page, @order_item = OrderItem.new, form_for @order_item includes :order_quantity and hidden_field @product.id. 

2.3.2  order_items#create action
  When click on "Add to Cart" will be corresponding to create action.
  order_id is stored in session[:order_id]
  if !@order = Order.find_by(id: session[:order_id])
    @order = Order.create
    session[:order_id] = @order.id
  end
  if order_item already esists in @order, add quantity
  else
    OrderItem.create(order_id:@order.id, product_id: params[:order_item][:product_id], product_quatity:params[:order_item][:product_quantity])
  end
  flash.now and stay on the page?

2.3.3 view shopping cart
  if !@order = Order.find_by(id: session[:order_id])
    @order = Order.create
    session[:order_id] = @order.id
  end 
  <%= link_to order_path(@order.id) %>

  Displaying product image
  Edit order_item quantity #edit action with json respond?
  Delete order_item, directed to order after destroyed
  Empty the shopping cart: delete order
  check stock, if order_item.product_quantity > product.stock, show warning


2.3.4 checkout
  before_checkout: check stock, order_item.product_quantity < product.stock
  Filling address
  payment

2.3.5 Admin check orders and edit order status

3.Users


Admin page useful link eg: uncategorized products
_product_list_admin_view => _product_list (if admin stock: stock number else availability)
product show.html if admin show category and stock

current position, eg: for him > cards

order cupon


?? heroku no image in assets?





