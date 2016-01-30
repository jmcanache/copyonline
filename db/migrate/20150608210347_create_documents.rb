class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :folder, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_attachment :documents, :file
  end
end
