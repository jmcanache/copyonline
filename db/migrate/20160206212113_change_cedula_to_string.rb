class ChangeCedulaToString < ActiveRecord::Migration
  def change
  	change_column :users, :cedula, :integer
  end
end