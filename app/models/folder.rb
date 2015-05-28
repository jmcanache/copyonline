class Folder < ActiveRecord::Base
  belongs_to :order
  belongs_to :service

  validates :description, length: { maximum: 300 }
end
