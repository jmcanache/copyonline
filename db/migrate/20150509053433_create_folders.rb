class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.float :price
      t.timestamps null: false
    end
    add_reference :folders, :order, index: true
  end
end
