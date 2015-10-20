class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :workplace
  belongs_to :science_degree
  belongs_to :education_degree
  has_many :awards

  validates :first_name, :last_name, :middle_name, :nationality,
            :home_address, :home_phone, :work_phone,
            length: { maximum: 255 }
end
