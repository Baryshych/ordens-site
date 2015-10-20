class Workplace < ActiveRecord::Base
  include Tokenable
  
  validates :title, presence: true
end
