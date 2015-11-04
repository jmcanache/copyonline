class ServicesController < ApplicationController

  before_action :required_admin, only: [:edit, :index, :update]

  def index
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
