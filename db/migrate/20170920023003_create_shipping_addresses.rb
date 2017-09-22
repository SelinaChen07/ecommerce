class CreateShippingAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :lastname
      t.string :firstname
      t.string :phone
      t.string :email
      t.string :line1
      t.string :line2
      t.string :city
      t.string :state
      t.string :postcode
      t.integer :user_id

      t.timestamps
    end

    add_column :shipping_addresses, :country, :string, default:"Australia"
    
  end
end
