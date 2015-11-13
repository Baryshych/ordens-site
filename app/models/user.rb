class User < ActiveRecord::Base
  include PgSearch

  ADMIN = 'admin'
  INITIATOR = 'petition initiator'
  
  pg_search_scope :search, against: [:email, :name, :post, :phone]

  has_many :awards
  has_many :profiles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable

  validates :email, :name, :post, :phone, length: { maximum: 255 }
  validates :email, presence: true
  validates :password, presence: true, on: :create

  serialize :permissions

  scope :newest, -> { order('created_at DESC') }

  def display_name
    name.blank? ? email : name
  end
end
