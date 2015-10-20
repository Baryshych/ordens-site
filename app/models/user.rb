class User < ActiveRecord::Base
  has_many :awards
  has_many :profiles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable

  validates :email, :name, :post, :phone, length: { maximum: 255 }
  validates :email, :password, presence: true

  def display_name
    name.blank? ? email : name
  end
end
