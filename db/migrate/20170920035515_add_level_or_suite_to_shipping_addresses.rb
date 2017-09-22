class AddLevelOrSuiteToShippingAddresses < ActiveRecord::Migration[5.0]
  def change
    rename_column :shipping_addresses, :line1, :level_or_suite
    rename_column :shipping_addresses, :line2, :street_address
  end
end
