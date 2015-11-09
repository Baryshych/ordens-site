class AwardTypesController < ApplicationController

  def index
    render json: AwardType.select(:id, :title)
  end

  def show
    render json: AwardType.find(params[:id])
  end

  def create
    award_type = AwardType.new(award_type_params)
    award_type.user_id = current_user.id
    if award_type.save
      render json: { id: award_type.id }
    else
      render json: { errors: award_type.errors.full_messages }, status: 422
    end
  end

  def update
    award_type = AwardType.find(params[:id])
    if award_type.update_attributes(award_type_params)
      render json: { id: award_type.id }
    else
      render json: { errors: award_type.errors.full_messages }, status: 422
    end
  end

  private

  def award_type_params
    params.permit(:title)
  end
end
