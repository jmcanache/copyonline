class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nombre
      t.string :apellido
      t.string :telefono
      t.string :cedula
      t.string :login
      t.string :passwrod

      t.timestamps null: false
    end
  end
end
