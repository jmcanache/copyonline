class AddAttributeToServices < ActiveRecord::Migration
  def change
    add_column :services, :ink, :string
  end
end
