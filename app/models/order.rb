class Order < ActiveRecord::Base
  has_many :folders, dependent: :destroy
  has_many :documents
  belongs_to :payment
  belongs_to :user

  attr_accessor :servicio, :hoja, :color, :blanco_negro

  accepts_nested_attributes_for :documents
  accepts_nested_attributes_for :folders #para poder usar los campos de folders en el form de orders/new

  validates_associated :folders
  
  def self.ordenes(user_id, status)
    ds_ordenes = Array.new
    folderID = 0
  	Order.where(:status => status, :user_id => user_id).find_each do |order|
      hash = Hash.new
      ds_folder = []
      ds_doc = []
      hash[:order] = order
      Folder.where(:order_id => order.id).find_each do |folder|
        ds_folder_servicio = []
        servicio = Service.find(folder.service_id)
        ds_folder_servicio.push folder
        ds_folder_servicio.push servicio
        ds_folder.push ds_folder_servicio
        folderID = folder.id
        #logger.debug(ds_folder.inspect)
      end
      Document.where(:folder_id => folderID).find_each do |doc|
        ds_doc.push doc
      end
      hash[:folder] = ds_folder
      hash[:document] = ds_doc
      ds_ordenes.push hash
  	end
    return ds_ordenes
  end
end
