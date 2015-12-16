class Contact < ActionMailer::Base
	default :from => 'copyonlinetest@gmail.com'

	# send a signup email to the user, pass in the user object that   contains the user's email address
	def send_email(data)
	    @data = data
	    mail( :to => "copyonlinetest@gmail.com", :subject => @data[:asunto] )
	end

end