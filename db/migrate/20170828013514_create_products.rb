class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :abstract
      t.text :description
      t.decimal :price, precision:8, scale:2
      

      t.timestamps
    end
    add_column :products, :stock, :integer, default: 10
  end
end
