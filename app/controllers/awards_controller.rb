class AwardsController < ApplicationController

  def index
    render json: Award.where(profile_id: params[:profile_id])
  end

  def show
    render json: Award.find(params[:id])
  end

  def create
    award = Award.new(award_params)
    award.user_id = current_user.id
    if award.save
      render json: { id: award.id }
    else
      render json: { errors: award.errors.full_messages }, status: 422
    end
  end

  def update
    award = Award.find(params[:id])
    if award.update_attributes(award_params)
      render json: { id: award.id }
    else
      render json: { errors: award.errors.full_messages }, status: 422
    end
  end

  def destroy
    award = Award.find(params[:id])
    if award.destroy
      head :ok
    else
      render json: { errors: award.errors.full_messages }, status: 422
    end
  end

  private

  def award_params
    params.permit(:profile_id, :award_type_id, :document_quality_id,
      :petition_initiator_id, :status, :result, :comission_date,
      :petition_got_at, :comission_protocol_number, :registry_petition_number,
      :award_cause)
  end
end
