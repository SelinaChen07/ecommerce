# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180312011834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categorizations", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["product_id", "category_id"], name: "index_categorizations_on_product_id_and_category_id", unique: true, using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "product_quantity"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "status",              default: "in cart"
    t.integer  "shipping_address_id"
    t.boolean  "reserve_stock",       default: false
    t.datetime "reserve_until"
    t.string   "transaction_id"
    t.integer  "confirmation_num"
    t.index ["confirmation_num"], name: "index_orders_on_confirmation_num", using: :btree
    t.index ["reserve_stock"], name: "index_orders_on_reserve_stock", using: :btree
    t.index ["status"], name: "index_orders_on_status", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.string   "abstract"
    t.text     "description"
    t.decimal  "price",       precision: 8, scale: 2
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "stock",                               default: 10
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.string   "lastname"
    t.string   "firstname"
    t.string   "phone"
    t.string   "email"
    t.string   "level_or_suite"
    t.string   "suburb_or_city"
    t.string   "state"
    t.string   "postcode"
    t.integer  "user_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "country",        default: "Australia"
    t.string   "street_address"
  end

end
