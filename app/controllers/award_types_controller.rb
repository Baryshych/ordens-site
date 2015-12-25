class AwardTypesController < ApplicationController

  def index
    render json: AwardType.select(:id, :title)
  end

  def show
    render json: AwardType.find(params[:id])
  end

  def create
    award_type = AwardType.new(award_type_params)
    if !params[:force_save] && existing = award_type.find_similar
      render json: { warning: true, existing_item: existing }
      return
    end
    award_type.user_id = current_user.id
    # check whether we have "id" or new category name
    # in case of id "123".to_i.to_s == "123"
    category_id = award_type_params[:award_category_id].to_i.to_s
    if category_id != award_type_params[:award_category_id]
      category_id = AwardCategory.find_or_create_by(
        title: award_type_params[:award_category_id],
        user_id: current_user.id
      ).id
    end
    award_type.award_category_id = category_id
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
    params.permit(:title, :award_category_id)
  end
end
