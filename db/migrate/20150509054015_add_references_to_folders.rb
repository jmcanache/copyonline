class AddReferencesToFolders < ActiveRecord::Migration
  def change
    add_reference :folders, :service, index: true
  end
end
