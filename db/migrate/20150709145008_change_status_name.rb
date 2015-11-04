class ChangeStatusName < ActiveRecord::Migration
  def change
  	rename_column :payments, :status, :process
  end
end
