class AddJnToUser < ActiveRecord::Migration
  def change
    add_column :users, :jn, :integer
  end
end
