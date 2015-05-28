class ServicesController < ApplicationController
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

  def edit
    @services = Service.find(params[:id])
  end
end
