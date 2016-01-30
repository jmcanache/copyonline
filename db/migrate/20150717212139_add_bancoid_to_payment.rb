class AddBancoidToPayment < ActiveRecord::Migration
  def change
    add_reference :payments, :banco, index: true, foreign_key: true
  end
end
