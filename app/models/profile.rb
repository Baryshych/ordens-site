class Profile < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search,
                  against: [:first_name, :last_name, :middle_name, :post]

  belongs_to :user
  belongs_to :workplace
  belongs_to :science_degree
  belongs_to :education_degree
  has_many :awards, dependent: :destroy

  validates :first_name, :last_name, :middle_name, :nationality,
            :home_address, :home_phone, :work_phone,
            length: { maximum: 255 }
  validates :last_name, presence: true

  scope :newest, -> { order('created_at DESC') }

  attr_accessor :error

  def last_award
    awards.last
  end

  def full_name
    [last_name, first_name, middle_name].compact.join(' ')
  end
end
