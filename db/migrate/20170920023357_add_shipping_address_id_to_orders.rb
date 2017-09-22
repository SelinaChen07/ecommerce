class AddShippingAddressIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :shipping_address_id, :integer
  end
end
