class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  add_flash_types :warning

  def required_admin
    redirect_to '/' unless current_user.admin?
  end

  protected

  def configure_devise_permitted_parameters
    registration_params = [:nombre, :apellido, :telefono, :cedula, :email, :password, :password_confirmation, :jn, :city]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end

end
