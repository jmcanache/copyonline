class AddAdmins < SeedMigration::Migration
  	def up
	  	User.create!({
	        :nombre => "copyAdmin",
	        :apellido => "copyAdmin",
	        :telefono => "04249305919",
	        :cedula => "1",
	        :created_at => "2015-11-26 15:37:23",
	        :updated_at => "2015-11-26 15:37:23",
	        :email => "copyonline21@gmail.com",
	        :password => "12345678",
	        :password_confirmation => "12345678",
	        :remember_created_at => nil,
	        :sign_in_count => 0,
	        :current_sign_in_at => "2015-11-26 15:37:24",
	        :last_sign_in_at => "2015-11-26 15:37:25",
	        :current_sign_in_ip => "192.168.0.102",
	        :last_sign_in_ip => "192.168.0.102",
	        :admin => 1
	    })
  	end

  	def down
	  	User.destroy_all({
	        :nombre => "copyAdmin",
	        :apellido => "copyAdmin",
	        :telefono => "04249305919",
	        :cedula => "1",
	        :created_at => "2015-11-26 15:37:23",
	        :updated_at => "2015-11-26 15:37:23",
	        :email => "copyonline21@gmail.com",
	        :password => "12345678",
	        :password_confirmation => "12345678",
	        :remember_created_at => nil,
	        :sign_in_count => 0,
	        :current_sign_in_at => "2015-11-26 15:37:24",
	        :last_sign_in_at => "2015-11-26 15:37:25",
	        :current_sign_in_ip => "192.168.0.102",
	        :last_sign_in_ip => "192.168.0.102",
	        :admin => 1
	    })
  	end
end
