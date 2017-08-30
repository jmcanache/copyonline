class AddSenderToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :sender, :string
  end
end
