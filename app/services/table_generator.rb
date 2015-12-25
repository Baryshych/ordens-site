class TableGenerator

  def generate(profiles)
    table = {}
    profiles.each do |p|
      next if p.error.present? # filtered
      table[p.last_award.award_type.title] ||= []
      table[p.last_award.award_type.title] << {
        2 => about_information(p),
        3 => "#{p.years_worked_total}/#{p.years_worked_on_current_place}",
        4 => list_awards(p),
        5 => p.archievements,
        6 => petition_data(p.last_award),
        7 => p.last_award.document_quality.try(:description),
        8 => p.last_award.status
      }
    end
    table.sort.map { |key, val| [key, val.sort_by { |x| x[2] }] }.to_h
  end

  def about_information(profile)
    text = profile.full_name
    text << "\n Місце роботи: #{profile.workplace.try(:title)}\n"
    text << "Посада: #{profile.post}\n"
    text << 'Науковий ступінь, вчене звання: '
    text << (profile.science_degree.try(:title) || 'немає')
    text << ', '
    text << (profile.education_degree.try(:title) || 'немає')
    if profile.born_at
      text << "\nДата народження: " + profile.born_at.strftime('%m.%d.%Y')
    end
  end

  def list_awards(profile)
    text = ''
    profile.awards.each do |award|
      next if award.status != Award::APPROVED ||
              award.id == profile.last_award.id
      text << "\n" + award.award_type.title
      if award.comission_date
        text << " (#{award.comission_date.strftime('%Y')})"
      end
    end
    text.strip
  end

  def petition_data(award)
    text = award.petition_initiator.try(:title) || ''
    text << "\n(вх. №#{award.registry_petition_number}"
    if award.comission_date
      text << " від #{award.comission_date.strftime('%m.%d.%Y')}р.)"
    else
      text << ')'
    end
  end
end
