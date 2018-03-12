class AddConfirmationNumToOrders < ActiveRecord::Migration[5.0]
  def change
  	add_column :orders, :confirmation_num, :integer
  	add_index :orders, :confirmation_num
  end
end
