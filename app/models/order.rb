class Order < ActiveRecord::Base
  has_many :folders
end
