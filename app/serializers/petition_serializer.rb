class PetitionSerializer < ActiveModel::Serializer
  attributes :id, :petitioner, :first_name, :last_name, :middle_name,
             :nationality, :home_address, :home_phone, :work_phone,
             :status, :years_worked_total, :years_worked_on_current_place,
             :education_degree_id, :science_degree_id, :born_at, :male,
             :education, :post, :archievements, :special_degree,
             :party_membership, :award_cause, :comment, :workplace,
             :workplace_address, :created_at, :updated_at, :formatted_date,
             :full_name, :formatted_time, :status_class, :award_type_title,
             :education_degree_title, :science_degree_title

  has_one :petitioner

  def status
    object.status.present? ? object.status : Petition::NEW
  end

  def status_class
    case status
    when Petition::NEW then 'warning'
    when Petition::DECLINED then 'default active'
    when Petition::IMPORTED then 'info'
    end
  end

  def formatted_date
    object.created_at.strftime('%d.%m.%Y')
  end

  def formatted_time
    object.created_at.strftime(' %H:%M')
  end

  def award_type_title
    object.award_type.try(:title)
  end

  def education_degree_title
    object.education_degree.try(:title)
  end

  def science_degree_title
    object.science_degree.try(:title)
  end
end
