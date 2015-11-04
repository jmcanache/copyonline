class Payment < ActiveRecord::Base
	has_many :orders
	has_many :folders, through: :orders
	belongs_to :banco

	validates :transfer_number, length: {maximum: 1000}
end
