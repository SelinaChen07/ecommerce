class AddIndexToCategorization < ActiveRecord::Migration[5.0]
  def change
  	add_index :categorizations, [:product_id, :category_id], unique:true
  end
end
