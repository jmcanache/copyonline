class Transfer < ApplicationMailer
  	def transfer_info(data, banco)
	    @data = data
	    @banco = banco
	    mail( :to => "copyonlinetest@gmail.com", :subject => "Nueva orden realizada")
	end

	def send_email(data)
	    @data = data
	    mail( :to => "copyonlinetest@gmail.com", :subject => @data[:asunto] )
	end
end