class AwardCategory < ActiveRecord::Base
  belongs_to :user
  has_many :award_types

  validates :title, presence: true, length: { maximum: 255 }
end
