class ChangeLimitOfTransferNumber < ActiveRecord::Migration
  def change
  	change_column :payments, :transfer_number, :integer, :limit => 8
  end
end
