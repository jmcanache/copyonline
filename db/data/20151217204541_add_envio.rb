class AddEnvio < SeedMigration::Migration
  	def up
  		Service.create!({
		    title: "envio",
		    description: "------",
		    ink: "------",
		    price: 300,
		    created_at: "2015-11-26 15:37:23",
		    updated_at: "2015-11-26 15:37:23"
		})
  	end

  	def down
  		Service.destroy_all({
		    title: "envio",
		    description: "------",
		    ink: "------",
		    price: 300,
		    created_at: "2015-11-26 15:37:23",
		    updated_at: "2015-11-26 15:37:23"
		})
  	end
end
