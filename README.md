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

   has_many :categorizations
   has_many :categories, through: :categorizations
   
   has_many :order_items
   has_many :orders, through: :order_items
   

1.1.2 photos
  	product_id :integer
    image: string #use carrierwave uploader

    belongs_to :product, inverse_of: :photos

1.1.3 categorizations
	product_id: integer
	category_id: integer

	belongs_to :product
	belongs_to :category

1.1.4 categories
	name:string

	has_many :categorizations
	has_many :products, through: :categorizations


Seed products with photos
Add Category models