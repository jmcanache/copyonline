class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  #before_action :delete_session, only: [:procesar_order]

  def show
    session.delete(:envio)
    session.delete(:direccion)
    servicioEnvio = Service.where(:title => "envio").first
    @servicioEnvio = servicioEnvio[:price]
    @orders = Order.ordenes(current_user.id, 1)
    @titulo = "Ordenes a ser pagadas"
    if @orders.blank?
      return redirect_to :action => :new, warning: "No tiene ninguna orden para procesar"
    end
  end

  def show_pagadas
    session.delete(:envio)
    session.delete(:direccion)
    @orders = Order.ordenes(current_user.id, 2)
    @titulo = "Ordenes pagadas"
    if @orders.blank?
      return redirect_to :action => :show, warning: "No tiene ninguna pagada"
    end
  end

  def new 
    @folders = Folder.new
    @documents = Document.new
    @orders = Order.new
    session.delete(:order_id)
    @titulo = "Crear nueva orden"
  end


  def create
    if(params[:order][:color] == "0" and params[:order][:blanco_negro] == "0")
      return redirect_to :action => :new, alert: "Debe elegir que tipo de color sera el servicio"
    end

    save_order = true
    if(params[:order][:color] == "1")
      servicio = Service.where(:title => params[:order][:servicio], :description => params[:order][:hoja], :ink => 'color').first
      cantidad = params[:folder][:amount_color]
      guardar = iniciar_transaccion(servicio, save_order, cantidad)
      save_order = false
    end

    if(params[:order][:blanco_negro] == "1")
      servicio = Service.where(:title => params[:order][:servicio], :description => params[:order][:hoja], :ink => 'blanco_negro').first
      cantidad = params[:folder][:amount_blanco_negro]
      guardar = iniciar_transaccion(servicio, save_order, cantidad)
    end

    if guardar 
      return redirect_to :action => :new, notice: ('Orden procesada correctamente. Lo invitamos dirigirse a la seccion de "Ordenes realizadas" para realizar sus pagos')
    else
      return redirect_to :action => :new, alert:("Ocurrio un problema en su orden, intente otra vez")
    end
  end

  def procesar_order
    aux = params.count
    @titulo = "Procesar ordenes"
    servicioEnvio = Service.where(:title => "envio").first

    if(aux == 7)
      return redirect_to :action => :show,  warning: "Intente de nuevo"
    end
    cont = 0
    if (params[:envio] == "0")
      @precio = 0
    else
      @precio = servicioEnvio[:price]
    end
    @bancos = Banco.all.order(descripcion: :asc)
    session[:ordenes_procesadas] = []
    while aux > 7
      if params["#{cont}"].present?
        session[:ordenes_procesadas].push params["#{cont}"]
        Folder.where(:order_id => params["#{cont}"]).find_each do |folder|
          @precio += folder[:price]
        end
        aux -= 1
      end
      cont += 1
    end
    session[:envio] = params[:envio]
    session[:direccion] = params[:direccion]
  end

  def transferencia_pagada
    todo_ok = true
    servicioEnvio = Service.where(:title => "envio").first
    Payment.transaction do
      if session[:envio] == "1"
        precio = params[:precio].to_f + servicioEnvio[:price].to_f
      end
      payment = Payment.new(:shipping => session[:envio], :transfer_number => params[:transfer_number], :shipping_address => session[:direccion], :Total_price => params[:precio], :banco_id => params[:banco])
      if payment.save 
        session[:ordenes_procesadas].each do |orderID|
          search_order = Order.find(orderID)
          if !search_order.update(payment_id: payment.id, status: 2)
            todo_ok = false
          end
        end
      else
        todo_ok = false
      end

      if todo_ok
        redirect_to :controller => :orders, :action => :show_pagadas, notice:('Pago realizado')
      else
        redirect_to :controller => :orders, :action => :show, alert:('Ocurrio un problema en el pago, intente de nuevo')
        raise ActiveRecord::Rollback, "No guardo nada"
      end
    end
  end

  def ver_detalles
    if Order.where(:id => params[:order_id]).exists?
      @order = Order.includes({folders: :document}, {folders: :service}).find(params[:order_id]) 
      redirect_to :controller => :orders, :action => :show  if @order[:user_id] != current_user.id
    else
      redirect_to :controller => :orders, :action => :show
    end
  end

  def eliminar_orden
    if(Order.find(params[:order_id]).destroy)
      redirect_to :controller => :orders, :action => :show, notice:('Orden eliminada')
    else
      redirect_to :controller => :orders, :action => :show, alert:('Ocurrio un problemas al intentar eliminar la orden')
    end
  end

  private

  def iniciar_transaccion(servicio, save_order, cantidad)
    todo_ok = true
    Order.transaction do
      if save_order
        @orders = Order.new(:user_id => current_user.id)
        if @orders.save 
          session[:order_id] = @orders.id
        else
          todo_ok = false
          break
        end
      end
      precio = cantidad.to_f * servicio[:price].to_f
      @folders = Folder.new(price: precio, order_id: session[:order_id], service_id: servicio[:id], amount: cantidad, description: params[:folder][:description])
      if @folders.save and todo_ok == true
        params[:document][:file].each do |doc|
          @document = Document.new(:file => doc, :folder_id => @folders.id)
          if !@document.save 
            todo_ok = false
          end
        end
      else
        todo_ok = false
      end 
      if todo_ok == false
        raise ActiveRecord::Rollback, "No guardo nada"
      end
    end
    return todo_ok
  end
end
