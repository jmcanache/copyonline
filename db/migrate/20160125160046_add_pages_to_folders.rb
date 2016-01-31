class AddPagesToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :pages, :string
  end
end
