class Award < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile
  belongs_to :award_type
  belongs_to :document_quality
  belongs_to :petition_initiator

  validates :status, :result, :comission_protocol_number,
            :registry_petition_number, length: { maximum: 255 }
  validates :profile_id, :award_type_id, presence: true
end