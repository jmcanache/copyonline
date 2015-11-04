class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.boolean :shipping
      t.text :shipping_address
      t.string :status

      t.timestamps null: false
    end
  end
end
