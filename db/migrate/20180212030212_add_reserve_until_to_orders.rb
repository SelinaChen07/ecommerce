class AddReserveUntilToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :reserve_until, :datetime
  end
end
