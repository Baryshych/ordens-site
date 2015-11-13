class ProfilesSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :post, :workplace_title, :workplace_address,
             :awards

  def awards
    $award_types ||= AwardType.select(:id, :title)
    object.awards.map do |aw|
      title = $award_types.find { |x| x.id == aw.award_type_id }.try(:title)
      if aw.comission_date.present?
        year = '(' + aw.comission_date.strftime('%Y') + ')'
      else
        year = ''
      end
      ["#{title} #{year}", year]
    end.sort_by { |x| x[1] }.reverse.map(&:first)
  end

  def workplace_title
    object.workplace.try(:title)
  end

  def workplace_address
    object.workplace.try(:address)
  end

  def workplace
    @workplace || object.workplace
  end

  def full_name
    "#{object.last_name} #{object.first_name} #{object.middle_name}"
  end
end
