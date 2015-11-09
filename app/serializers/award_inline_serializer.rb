class AwardInlineSerializer < ActiveModel::Serializer
  attributes :id, :profile_id, :award_type_id, :document_quality_id,
             :petition_initiator_id, :status, :result, :comission_date,
             :petition_got_at, :comission_protocol_number,
             :registry_petition_number, :award_cause, :title,
             :petition_initiator_title, :document_quality_description

  def title
    object.award_type.title
  end

  def petition_initiator_title
    object.petition_initiator.try :title
  end

  def document_quality_description
    object.document_quality.try :description
  end
end

