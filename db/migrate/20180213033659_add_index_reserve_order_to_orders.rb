class AddIndexReserveOrderToOrders < ActiveRecord::Migration[5.0]
  def change
  	add_index :orders, :reserve_stock
  end
end
