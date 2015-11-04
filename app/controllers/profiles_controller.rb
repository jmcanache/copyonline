class ProfilesController < ApplicationController

	before_action :authenticate_user!

	def edit
		@usuario = User.find(current_user.id)
	end

	def update
		@usuario = User.find(current_user.id)
   		if(@usuario.update(user_params))
     		redirect_to '/'
     	else
     		render action: :edit
    	end
	end

	private
	def user_params
      params.require(:user).permit(:nombre, :apellido, :email, :telefono, :cedula)
    end
end
#if(user.update(:nombre => params['profile']['nombre'], :apellido => params['profile']['apellido'], :email => params['profile']['email'], :cedula => params['profile']['cedula'], :telefono => params['profile']['telefono']))

