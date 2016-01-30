class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :orders
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :nombre, :apellido, presence: true,
			  					format: { with: /\A[a-z A-Z]+\z/ },
			  					length: { in: 2..20 }
  validates :cedula, presence: true,
  					 length: { maximum: 8 },
  					 numericality: { only_integer: true },
  					 uniqueness: true
  validates :telefono, presence:true,
                       format: { with: /(04)(12|14|16|24|26)([0-9]{7,7})/, message: "Story title is required"}

  def admin?
    self.admin == 1
  end
end
