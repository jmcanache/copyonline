class PaymentsController < ApplicationController

  before_action :required_admin, only: [:procesar_transferencia, :ver_detalles, :orden_finalizada]

  def procesar_transferencia
    if params[:process] == "1"
      @titulo = "Ordenes realizadas"
    else
      @titulo = "Ordenes finalizadas"
    end

  	@payment = Payment.includes({orders: [{folders: :service}, {folders: :document}, :user]}, :banco).where(:process => params[:process])
    if @payment.blank?
      if params[:process] == "2"
       params[:warning] = "No tiene ninguna orden procesada"
      else
       params[:warning] = "No tiene ordenes por procesar"
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
      session[:count] -= 1
      redirect_to :action => "procesar_transferencia", :process => 1
    end
  end

  def count_new_orders
    session[:count] = Payment.where(:process => 1).count
    respond_to do |format|
      format.json { render json: session[:count] }
    end
  end

end
