class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :user_id

      t.timestamps
    end
    add_column :orders, :status, :string, :default => "in cart"
  end
end
