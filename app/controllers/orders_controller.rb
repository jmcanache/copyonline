class OrdersController < ApplicationController
  #before_action :authenticate_user!, except: [:show, :index]
  def index
  end

  def show
  end

  def new
    @orders = Order.new
    @folders = Folder.new
  end

  def create
    #logger.debug(params[:folder][:description])
    #@orders = Order.new(status: params[:order][:status], shipping_address: params[:order][:shipping_address])
    # @orders = Order.new(order_params)

    @orders = Order.new(order_params)
    @folders = Folder.new
    if params[:order][:color].blank?
      params[:order][:color] = 'N/A'
    end
    servicio = Service.where(:title => params[:order][:servicio], :description => params[:order][:hoja], :ink => params[:order][:color]).first
    logger.debug(servicio.inspect)
    if !servicio.blank? and @orders.save 
      precio = params[:folder][:amount].to_f * servicio[:price].to_f
      @folders = Folder.new(price: precio, order_id: @orders.id, service_id: servicio[:id], amount: params[:folder][:amount], description: params[:folder][:description])
      if @folders.save
        logger.debug('Guardo')
      else
        render 'new'
        logger.debug('Error 1')
      end 
    else
      render 'new'
      logger.debug('Error 2')
    end
  end

    



      # orders = Order.new(shipping: params[:envio], shipping_address: params[:direccion])
      # servicio = Service.where(:title => params[:servicio], :description => "#{params[:hoja]}" + ', ' + "#{params[:color]}").first
      # logger.debug(servicio)

      #    if orders.save and !servicio.blank?
      #       precio = params[:cantidad].to_f * servicio[:price].to_f
      #       folders = Folder.new(price: precio, order_id: orders.id, service_id: servicio[:id], quantity: params[:cantidad], description: params[:descripcion])
      #       if folders.save
      #          logger.debug('Guardo')
      #       else
      #          redirect_to  :action => 'new'
      #          logger.debug('Error 1')
      #       end 
      #    else
      #       redirect_to  :action => 'new'
      #       logger.debug('Error 2')
      #    end
  

  def destroy
  end

  def edit
  end

  private

    def order_params
      params.require(:order).permit(:shipping, :shipping_address)
    end
end
