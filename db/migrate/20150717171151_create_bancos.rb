class CreateBancos < ActiveRecord::Migration
  def change
    create_table :bancos do |t|
      t.string :descripcion, null: false
      t.string :codigo, default: 0000

      t.timestamps null: false
    end
  end
end
