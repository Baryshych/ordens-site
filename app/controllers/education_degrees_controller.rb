class EducationDegreesController < ApplicationController
  def index
    render json: EducationDegree.all
  end

  def show
    render json: EducationDegree.find(params[:id])
  end

  def create
    education_degree = EducationDegree.new(education_degree_params)
    if !params[:force_save] && existing = education_degree.find_similar
      render json: { warning: true, existing_item: existing }
      return
    end
    education_degree.user_id = current_user.id
    if education_degree.save
      render json: { id: education_degree.id }
    else
      render json: { errors: education_degree.errors.full_messages }, status: 422
    end
  end

  def update
    education_degree = EducationDegree.find(params[:id])
    if education_degree.update_attributes(education_degree_params)
      render json: { id: education_degree.id }
    else
      render json: { errors: science_degree.errors.full_messages }, status: 422
    end
  end

  private

  def education_degree_params
    params.permit(:title)
  end
end