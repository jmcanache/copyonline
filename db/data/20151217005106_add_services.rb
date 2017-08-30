class AddServices < SeedMigration::Migration
  	require 'csv'

  	def up
		data_file = Rails.root.join('db/data/services.csv')

		CSV.foreach(data_file) do |row|
		  Service.create!(
		    title: row[1],
		    description: row[2],
		    ink: row[3],
		    price: row[4],
		    created_at: row[5],
		    updated_at: row[6]
		    )
		end
  	end

	def down
		data_file = Rails.root.join('db/data/services.csv')

		CSV.foreach(data_file) do |row|
		  Service.destroy_all(
		    title: row[1],
		    description: row[2],
		    ink: row[3],
		    price: row[4],
		    created_at: row[5],
		    updated_at: row[6]
		    )
		end
	end
end
