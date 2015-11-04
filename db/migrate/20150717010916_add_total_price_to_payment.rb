class AddTotalPriceToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :Total_price, :integer, null: false
  end
end
