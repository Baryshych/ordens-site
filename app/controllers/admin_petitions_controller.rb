class AdminPetitionsController < ApplicationController

  def index
    petitions = Petition.includes(:petitioner, :award_type, :education_degree,
                                  :science_degree).newest
    petitions = petitions.search(params[:search]) if params[:search].present?
    if params[:petitioner_id].present?
      petitions = petitions.where(petitioner_id: params[:petitioner_id])
    end
    if params[:status].present?
      petitions = petitions.where(status: params[:status])
    end
    per_page = 20
    render json: petitions.paginate(page: params[:page], per_page: per_page),
           meta: { total_entries: petitions.count, per_page: per_page },
           root: 'petitions'
  end

  def show
    render json: Petition.find(params[:id]), root: 'petition'
  end

  def update
    petition = Petition.find(params[:id])
    petition.status = params[:status]
    petition.save
    head :ok
  end

  def similar
    petition = Petition.find(params[:id])
    similar = Profile.where(
      '(first_name = :first_name AND last_name = :last_name)' \
      ' OR ' \
      '(first_name = :first_name AND middle_name = :middle_name)' \
      ' OR ' \
      '(middle_name = :middle_name AND last_name = :last_name)',
      first_name: petition.first_name,
      last_name: petition.last_name,
      middle_name: petition.middle_name
    ).limit(5)

    render json: similar, root: 'profiles'
  end

  def import
    petition = Petition.find(params[:id])
    attributes = petition.attributes
    attributes.delete('id')
    profile = Profile.new(attributes.slice(*Profile.column_names))
    profile.user_id = current_user.id
    if petition.workplace.present?
      workplace = Workplace.find_or_create_by(title: petition.workplace)
      workplace.address ||= petition.workplace_address
      workplace.save
      profile.workplace_id = workplace.id
    end
    profile.save
    if petition.award_id.present?
      award = Award.new(
        profile_id: profile.id,
        award_type_id: petition.award_id,
        petition_got_at: Time.zone.now,
        award_cause: petition.award_cause
      )
      award.save
    end
    petition.update_column('status', Petition::IMPORTED)
    render json: profile, root: 'profile'
  end

  def new_count
    render json: { count: Petition.where(status: Petition::NEW).count }
  end
end
