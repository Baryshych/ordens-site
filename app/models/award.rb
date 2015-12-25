class Award < ActiveRecord::Base
  WAITING = 'очікує розгляду'
  APPROVED = 'підтримано'
  DECLINED = 'відхилено'
  APPROVED_AS_EXCEPTION = 'підтримано як виняток'
  WITHDRAWN = 'знято з розгляду'

  belongs_to :user
  belongs_to :profile
  belongs_to :award_type
  belongs_to :document_quality
  belongs_to :petition_initiator

  validates :status, :result, :comission_protocol_number,
            :registry_petition_number, length: { maximum: 255 }
  validates :profile_id, :award_type_id, presence: true

  default_scope -> { order('awards.comission_date DESC') }
  scope :got, -> { where(status: APPROVED) }
end
