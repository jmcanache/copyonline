class RemovePassLoginFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :passwrod, :string
    remove_column :users, :login, :string
  end
end
