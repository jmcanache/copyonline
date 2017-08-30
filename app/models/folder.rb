class Folder < ActiveRecord::Base
  belongs_to :order
  belongs_to :service
  has_many :document, dependent: :destroy

  attr_accessor :amount_color, :amount_blanco_negro

  validates :amount, :numericality => { :less_than_or_equal_to => 1000000 }
  #validates :pages, presence:true,
   #                    format: { with: /A[0-9]{1,5}( *- *[0-9]{1,5})*z/, message: "Story title is required"}
end
