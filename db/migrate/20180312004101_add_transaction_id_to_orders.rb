class AddTransactionIdToOrders < ActiveRecord::Migration[5.0]
  def change
  	add_column :orders, :transaction_id, :string
  	add_index :orders, :status
  end
end
