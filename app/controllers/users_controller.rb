# encoding: utf-8
class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:panel]

	def index
		@services = Service.all
	end

	def panel
		@titulo = "Panel de gestión"
		if current_user.admin?
			return redirect_to :controller => :users, :action => :index
		end
	end
end
