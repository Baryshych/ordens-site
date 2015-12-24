class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :years_worked_total, :awards,
             :years_worked_on_current_place, :born_at, :male, :education, :post,
             :characteristic, :archievements, :special_degree,
             :party_membership, :first_name, :last_name, :middle_name,
             :nationality, :home_address, :home_phone, :work_phone,
             :science_degree_id, :education_degree_id, :workplace_id,
             :creator_name, :formatted_created_at, :formatted_updated_at,
             :workplace_title

  def awards
    object.awards.includes(:award_type,
                           :document_quality,
                           :petition_initiator).map do |award|
      AwardInlineSerializer.new(award, root: false).as_json
    end
  end

  def creator_name
    object.user.display_name
  end

  def formatted_created_at
    object.created_at.strftime('%d.%m.%Y %H:%M')
  end

  def formatted_updated_at
    object.updated_at.strftime('%d.%m.%Y %H:%M')
  end

  def workplace_title
    object.workplace.try(:title)
  end
end
