class DocumentQuality < ActiveRecord::Base
  include Tokenable
  belongs_to :user
  has_many :awards
  validates :description, presence: true
end
