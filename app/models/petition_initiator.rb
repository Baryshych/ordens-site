class PetitionInitiator < ActiveRecord::Base
  include Tokenable
  
  belongs_to :user
  validates :title, presence: true
end
