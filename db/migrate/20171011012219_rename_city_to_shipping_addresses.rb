class RenameCityToShippingAddresses < ActiveRecord::Migration[5.0]
  def change
  	rename_column :shipping_addresses, :city, :suburb_or_city
  end
end
