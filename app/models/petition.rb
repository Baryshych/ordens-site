class Petition < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search, against: [:first_name, :last_name, :middle_name,
    :post, :workplace]
  NEW = 'Нова заявка'
  DECLINED = 'Відхилено'
  IMPORTED = 'Прийнято до розгляду'

  belongs_to :petitioner
  belongs_to :award_type, foreign_key: :award_id

  validates :last_name, :workplace, :award_cause, presence: true

  def full_name
    [last_name, first_name, middle_name].compact.join(' ')
  end

  def status
    read_attribute(:status) || NEW
  end
end
