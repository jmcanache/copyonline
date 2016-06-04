class Transfer < ApplicationMailer
  	def transfer_info(data, banco)
	    @data = data
	    @banco = banco
	    mail( :to => "copyonlinetest@gmail.com, copyonline21@gmail.com, alibriceo85@gmail.com, fercanache84@gmail.com", :subject => "Nueva orden realizada")
	end

	def send_email(data)
	    @data = data
	    mail( :to => "copyonlinetest@gmail.com, copyonline21@gmail.com", :subject => @data[:asunto] )
	end
end
