### IMPORT PROFILES

def find_or_create_edegree(old_id)
  return if old_id.blank?
  @edegrees ||= JSON.parse(File.read(Rails.root.to_s + '/scripts/dumps/educationdegrees.json'))
  ed = @edegrees.find{ |x| x['id'] == old_id.to_s }
  return if ed.nil? || ed['edegree'].blank?
  EducationDegree.find_or_create_by!(title: ed['edegree'], user_id: @user.id)
end

def find_or_create_sdegree(old_id)
  return if old_id.blank?
  @sdegrees ||= JSON.parse(File.read(Rails.root.to_s + '/scripts/dumps/sciencedegrees.json'))
  sd = @sdegrees.find{ |x| x['id'] == old_id.to_s }
  return if sd.nil? || sd['sdegree'].blank?
  ScienceDegree.find_or_create_by!(title: sd['sdegree'], user_id: @user.id)
end

def find_or_create_workplace(old_id)
  return if old_id.blank?
  @works ||= JSON.parse(File.read(Rails.root.to_s + '/scripts/dumps/workplaces.json'))
  work = @works.find{ |x| x['id'] == old_id.to_s }
  return if work.nil? || work['name'].blank?
  Workplace.find_or_create_by!(title: work['name'], user_id: @user.id)
end

def find_post(old_id)
  return if old_id.blank?
  @posts ||= JSON.parse(File.read(Rails.root.to_s + '/scripts/dumps/posts.json'))
  post = @posts.find{ |x| x['id'] == old_id.to_s }
  return unless post
  post['text'].blank? ? nil : post['text']
end

def find_nationality(old_id)
  return if old_id.blank?
  @nats ||= JSON.parse(File.read(Rails.root.to_s + '/scripts/dumps/nationalities.json'))
  nat = @nats.find{ |x| x['id'] == old_id.to_s }
  return unless nat
  nat['text'].blank? ? nil : nat['text']
end

@user = User.first
@user ||= User.create(email: 'alex.hh@me.com', password: 'password')

people = JSON.parse(File.read(Rails.root.to_s + '/scripts/dumps/people.json'))

@profiles_done = Profile.select(:old_id).map(&:old_id)

people.each do |profile|
  next if @profiles_done.include?(profile['id'].to_i)
  p = Profile.new(user_id: @user.id)
  p.old_id                        = profile['id'].to_i
  p.male                          = profile['sex'].to_i != 0
  p.born_at                       = Time.at(profile['birth'].to_i)
  p.first_name                    = profile['firstname']
  p.middle_name                   = profile['middlename']
  p.last_name                     = profile['secondname']
  p.party_membership              = profile['PartyMembership']
  p.education                     = profile['Education']
  p.special_degree                = profile['SpecialDegree']
  p.home_address                  = profile['HomeAdress']
  p.home_phone                    = profile['HomePhoneNumber']
  p.work_phone                    = profile['WorkPhoneNumber']

  p.years_worked_total            = profile['TotalLengthOfService']
  p.years_worked_on_current_place = profile['CurrentLengthOfService']
  p.characteristic                = profile['Characteristic']
  p.archievements                 = profile['achievements']

  p.science_degree = find_or_create_sdegree(profile['ScienceDegreeId'])
  p.education_degree = find_or_create_edegree(profile['EducationDegreeId'])
  p.workplace = find_or_create_workplace(profile['WorkPlaceId'])

  p.post = find_post(profile['PostId'])
  p.nationality = find_nationality(profile['NationalityId'])
  if p.save
    # puts "#{profile['id']} -- saved"
  else
    puts "!!! #{profile['id']} -- NOT saved"
    @failed_ids ||= []
    @failed_ids << profile['id']
  end 
end
if @failed_ids
  puts @failed_ids
  abort
end


### IMPORT AWARDS
def find_status(number)
  number = number.to_i
  case number
  when 1
    'підтримано'
  when 2
    'відхилено'
  when 3
    'підтримано як виняток'
  when 4
    'знято з розгляду'
  else
    'очікує розгляду'
  end
end

def find_result(number)
  number = number.to_i
  case number
  when 1
    'Отримав'
  when 2
    'Не отримав'
  else
    'Невідомо'
  end
end

def find_or_create_category(number)
  number = number.to_i
  title = case number
          when 1
            'Державна нагорода (орден, грамота)'
          when 2
            'Почесне вання'
          when 3
            'Відзнака Верховної Ради'
          when 4
            'Відзнака Кабінету Міністрів'
          when 5
            'Відомча заохочувальна відзнака'
          else
            'Не визначено'
          end
  AwardCategory.find_or_create_by!(title: title, user_id: @user.id)
end

def find_or_create_award_type(old_id)
  return if old_id.blank?
  @atypes ||= JSON.parse(File.read(Rails.root.to_s + '/scripts/dumps/awardtypes.json'))
  type = @atypes.find{ |x| x['id'] == old_id.to_s }
  return if type.nil? || type['text'].blank?
  category = find_or_create_category(type['category'])
  AwardType.find_or_create_by!(title: type['text'], user_id: @user.id,
                               award_category: category)
end

def find_or_create_petition_initiator(old_id)
  return if old_id.blank?
  @subjects ||= JSON.parse(File.read(Rails.root.to_s + '/scripts/dumps/subjectpetitions.json'))
  initiator = @subjects.find{ |x| x['id'] == old_id.to_s }
  return if initiator.nil? || initiator['text'].blank?
  PetitionInitiator.find_or_create_by!(title: initiator['text'], user_id: @user.id)
end

def find_or_create_document_quality(old_id)
  return if old_id.blank?
  @docqs ||= JSON.parse(File.read(Rails.root.to_s + '/scripts/dumps/documentsqualities.json'))
  dq = @docqs.find{ |x| x['id'] == old_id.to_s }
  return if dq.nil? || dq['text'].blank?
  DocumentQuality.find_or_create_by!(description: dq['text'], user_id: @user.id)
end

ordens = JSON.parse(File.read(Rails.root.to_s + '/scripts/dumps/ordens.json'))

@awards_done = Award.select(:old_id).map(&:old_id)

ordens.each do |award|
  next if @awards_done.include?(award["id"].to_i)
  a = Award.new(user_id: @user.id)
  a.old_id = award["id"].to_i
  a.status = find_status(award["Status"])
  a.comission_date = Time.at(award["ComiteeDate"].to_i)
  a.comission_protocol_number = award["ProtocolComiteeNumber"]
  a.award_cause = award["AwardCause"]
  a.petition_got_at =  Time.at(award["PetitionGotDate"].to_i)
  a.registry_petition_number = award["RegistryPetitionNumber"]
  a.result = find_result(award["AwardGot"])

  a.profile_id = Profile.where(old_id: award["PersonId"].to_i).pluck(:id).first

  a.award_type = find_or_create_award_type(award["AwardTypeId"])
  a.petition_initiator = find_or_create_petition_initiator(award["SubjectPetitionId"])
  a.document_quality = find_or_create_document_quality(award["DocumentsQualityId"])
  if a.save
    # puts "#{award['id']} -- saved"
  else
    puts "!!! #{award['id']} -- NOT saved"
    @failed_ids2 ||= []
    @failed_ids2 << award['id']
  end 
end

if @failed_ids2
  puts "Failed awards"
  puts @failed_ids2
end