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

	def user_info
		@user = User.find(params[:user_id])
	end

	def del
		array = Order.pluck(:id)
		Order.destroy(array)
		redirect_to action: :index
	end
end
