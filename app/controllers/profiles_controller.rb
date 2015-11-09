class ProfilesController < ApplicationController

  layout false
  
  def index
    render json: Profile.includes(:user, :workplace, :science_degree,
                                  :education_degree, :awards)
                        .newest
                        .paginate(page: params[:page]),
                 meta: { total_entries: Profile.count,
                         per_page: WillPaginate.per_page },
                 each_serializer: ProfilesSerializer
  end

  def show
    render json: Profile.find(params[:id])
  end

  def update
    profile = Profile.find(params[:id])
    if profile.update_attributes(profile_params)
      head :ok
    else
      render json: { errors: profile.errors.full_messages }, status: 422
    end
  end

  def create
    profile = Profile.new(profile_params)
    profile.user = current_user
    if profile.save
      head :ok
    else
      render json: { errors: profile.errors.full_messages }, status: 422
    end
  end

  def destroy
    Profile.find(params[:id]).destroy
    head :ok
  end

  private

  def profile_params
    params.permit(
      :years_worked_total, :years_worked_on_current_place, :born_at, :male,
      :education, :post, :characteristic, :archievements, :special_degree,
      :party_membership, :first_name, :last_name, :middle_name, :nationality,
      :home_address, :home_phone, :work_phone, :workplace_id, :science_degree_id,
      :education_degree_id
    )
  end
end
