class AddBancos < SeedMigration::Migration
  require 'csv'

  	def up
		data_file = Rails.root.join('db/data/bancos.csv')

		CSV.foreach(data_file) do |row|
		  	Banco.create!(
			    descripcion: row[1],
			    codigo: row[2],
			    created_at: row[3],
			    updated_at: row[4]
		    )
		end
  	end

	def down
		data_file = Rails.root.join('db/data/bancos.csv')

		CSV.foreach(data_file) do |row|
			Banco.destroy_all(
			    descripcion: row[1],
			    codigo: row[2],
			    created_at: row[3],
			    updated_at: row[4]
			)
		end
	end
end
