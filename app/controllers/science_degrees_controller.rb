class ScienceDegreesController < ApplicationController

  def index
    render json: ScienceDegree.all
  end

  def show
    render json: ScienceDegree.find(params[:id])
  end

  def create
    science_degree = ScienceDegree.new(science_degree_params)
    if !params[:force_save] && existing = science_degree.find_similar
      render json: { warning: true, existing_item: existing }
      return
    end
    science_degree.user_id = current_user.id
    if science_degree.save
      render json: { id: science_degree.id }
    else
      render json: { errors: science_degree.errors.full_messages }, status: 422
    end
  end

  def update
    science_degree = ScienceDegree.find(params[:id])
    if science_degree.update_attributes(science_degree_params)
      render json: { id: science_degree.id }
    else
      render json: { errors: science_degree.errors.full_messages }, status: 422
    end
  end

  private

  def science_degree_params
    params.permit(:title)
  end
end