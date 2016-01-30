class RemoveShippingFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :shipping, :tinyint
    remove_column :orders, :shipping_address, :text
    change_column_default :orders, :status, 1
  end
end
