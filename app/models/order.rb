class Order < ActiveRecord::Base
  has_many :folders
  attr_accessor :servicio, :hoja, :color
  accepts_nested_attributes_for :folders #para poder usar los campos de folders en el form de orders/new

  validates :shipping_address, presence: true, 
  							   length: { minimum: 8 }

end
