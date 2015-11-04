class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :transfer_number, null: false
      t.integer :shipping, null: false, default: 0, limit: 1
      t.text :shipping_address
      t.integer :status, null: false, default: 1, limit: 1

      t.timestamps null: false
    end
  end
end
