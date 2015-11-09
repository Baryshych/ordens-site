class DocumentQualitiesController < ApplicationController

  def index
    render json: DocumentQuality.select(:id, :description)
  end

  def show
    render json: DocumentQuality.find(params[:id])
  end

  def create
    document_quality = DocumentQuality.new(document_quality_params)
    document_quality.user_id = current_user.id
    if document_quality.save
      render json: { id: document_quality.id }
    else
      render json: { errors: document_quality.errors.full_messages }, status: 422
    end
  end

  def update
    document_quality = DocumentQuality.find(params[:id])
    if document_quality.update_attributes(document_quality_params)
      render json: { id: document_quality.id }
    else
      render json: { errors: document_quality.errors.full_messages }, status: 422
    end
  end

  private

  def document_quality_params
    params.permit(:title)
  end
end
