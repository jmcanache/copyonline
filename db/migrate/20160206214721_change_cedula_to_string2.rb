class ChangeCedulaToString2 < ActiveRecord::Migration
  def change
  	change_column :users, :cedula, :string
  end
end
