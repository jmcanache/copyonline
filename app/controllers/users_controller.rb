# encoding: utf-8
class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:panel]

	def index
		@services = Service.all
	end

	def panel
		@titulo = "Panel de gestión"
		if current_user.admin?
			session[:count] = Payment.where(:process => 1).count
			return redirect_to :controller => :users, :action => :index
		end
	end
end
