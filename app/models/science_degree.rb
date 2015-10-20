class ScienceDegree < ActiveRecord::Base
  include Tokenable
  
  belongs_to :user
  has_many :profiles
  validates :title, presence: true
end
