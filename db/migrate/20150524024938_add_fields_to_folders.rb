class AddFieldsToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :amount, :integer
    add_column :folders, :description, :text
  end
end
