class WorkplacesController < ApplicationController

  def index
    render json: Workplace.all
  end


  def show
    render json: Workplace.find(params[:id])
  end

  def create
    workplace = Workplace.new(workplace_params)
    if !params[:force_save] && existing = workplace.find_similar
      render json: { warning: true, existing_item: existing }
      return
    end
    workplace.user_id = current_user.id
    if workplace.save
      render json: { id: workplace.id }
    else
      render json: { errors: workplace.errors.full_messages }, status: 422
    end
  end

  def update
    workplace = Workplace.find(params[:id])
    if workplace.update_attributes(workplace_params)
      render json: { id: workplace.id }
    else
      render json: { errors: workplace.errors.full_messages }, status: 422
    end
  end

  private

  def workplace_params
    params.permit(:address, :title)
  end
end