class Folder < ActiveRecord::Base
  belongs_to :order
  belongs_to :service
  has_many :document, dependent: :destroy

  attr_accessor :amount_color, :amount_blanco_negro

  validates :description, length: { maximum: 300 }
  validates :amount, :numericality => { :less_than_or_equal_to => 1000000 }
end
