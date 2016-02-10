# encoding: utf-8
class ServicesController < ApplicationController

  before_action :required_admin, only: [:edit, :index, :update]

  def index
    @titulo = "Editar servicios"
    @services = Service.all
  end

  def show
  end

  def new
  end

  def create
  end

  def destroy
  end

  def contact_us
    @titulo = "Contáctenos"
  end

  def send_email
    Transfer.send_email(params).deliver
    return redirect_to action: :contact_us, notice:  "Email enviado!"
  end

  def update
    services = Service.find(params[:pk])
    if(services.update(:price => params[:value]))
      redirect_to action: :index
    end
  end

  def edit
    @services = Service.find(params[:id])
  end
end
