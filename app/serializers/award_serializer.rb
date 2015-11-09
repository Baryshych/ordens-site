class AwardSerializer < ActiveModel::Serializer
  attributes :id, :profile_id, :award_type_id, :document_quality_id,
             :petition_initiator_id, :status, :result, :comission_date,
             :petition_got_at, :comission_protocol_number,
             :registry_petition_number, :award_cause

  def result
    object.result || 'Невідомо'
  end
end
