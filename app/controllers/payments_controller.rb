class PaymentsController < ApplicationController

  before_action :required_admin, only: [:procesar_transferencia, :ver_detalles, :orden_finalizada]

  def procesar_transferencia
  	@payment = Payment.includes({orders: [{folders: :service}, {folders: :document}, :user]}, :banco).where(:process => params[:process]).paginate(page: params[:page], per_page: 1)
    if @payment.blank?
      if params[:process] == "2"
       redirect_to :controller => :users, :action => :index, warning: "No tiene ninguna order procesada"
      else
       redirect_to :controller => :users, :action => :index, warning: "No tiene ordenes por procesar"
      end
    end
    @process = params[:process]
  end

  def ver_detalles
    if Order.where(:id => params[:order_id]).exists?
      @order = Order.includes({folders: :document}, {folders: :service}).find(params[:order_id]) 
    else
      redirect_to :controller => :payments, :action => :procesar_transferencia
    end 
  end

  def orden_finalizada
    payment = Payment.find(params[:payment_id])
    if(payment.update(:process => 2))
      redirect_to :action => "procesar_transferencia", :process => 1
    end
  end

end
