class PetitionInitiatorsController < ApplicationController

  def index
    render json: PetitionInitiator.select(:id, :title)
  end

  def show
    render json: PetitionInitiator.find(params[:id])
  end

  def create
    petition_initiator = PetitionInitiator.new(petition_initiator_params)
    if !params[:force_save] && existing = petition_initiator.find_similar
      render json: { warning: true, existing_item: existing }
      return
    end
    petition_initiator.user_id = current_user.id
    if petition_initiator.save
      render json: { id: petition_initiator.id }
    else
      render json: { errors: petition_initiator.errors.full_messages }, status: 422
    end
  end

  def update
    petition_initiator = PetitionInitiator.find(params[:id])
    if petition_initiator.update_attributes(petition_initiator_params)
      render json: { id: petition_initiator.id }
    else
      render json: { errors: petition_initiator.errors.full_messages }, status: 422
    end
  end

  private

  def petition_initiator_params
    params.permit(:title)
  end
end
