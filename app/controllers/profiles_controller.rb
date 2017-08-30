# encoding: utf-8
class ProfilesController < ApplicationController

	before_action :authenticate_user!

	def edit
		@titulo = "Editar cuenta"
		@usuario = User.find(current_user.id)
		@city = @usuario.city == "Puerto Ordaz" ? ["Puerto Ordaz", "San Felix"] : ["San Felix", "Puerto Ordaz"]
		@jv = @usuario.jn == 0 ? [["V", "0"], ["J", "1"]] : [["J", "1"], ["V", "0"]] 
	end

	def update
		@usuario = User.find(current_user.id)
   		if(@usuario.update(user_params))
     		redirect_to action: :edit, notice:("Cambios realizados con éxito!")
     	else
     		render action: :edit
    	end
	end

	private
	def user_params
      params.require(:user).permit(:nombre, :apellido, :email, :telefono, :cedula, :jn, :city)
    end
end
#if(user.update(:nombre => params['profile']['nombre'], :apellido => params['profile']['apellido'], :email => params['profile']['email'], :cedula => params['profile']['cedula'], :telefono => params['profile']['telefono']))

