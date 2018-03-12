class AddReserveStockToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :reserve_stock, :boolean, default:false
  end
end
