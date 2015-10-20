class AwardType < ActiveRecord::Base
  include Tokenable
  belongs_to :user
  belongs_to :award_category
  has_many :awards
  
  validates :title, presence: true, length: { maximum: 255 }
end
