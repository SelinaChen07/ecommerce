class AddProductIdToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :product_id, :integer
  end
end
