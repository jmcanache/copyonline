class AddPaymentidToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :payment, index: true, foreign_key: true, default: nil
  end
end
