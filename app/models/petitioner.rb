class Petitioner < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable
  validates :name, :post, :phone, :workplace, :address, presence: true
  validates :password, presence: true, on: :create
  validates_confirmation_of :password, on: :create
  validates_uniqueness_of :email

  has_many :petitions
end
