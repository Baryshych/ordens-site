class UsersController < ApplicationController

  def index
    users = User.all.newest
    users = users.search(params[:search]) if params[:search].present?
    render json: users
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { id: user.id }
    else
      render json: { errors: user.errors.full_messages }, status: 422
    end
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      render json: { id: user.id }
    else
      render json: { errors: user.errors.full_messages }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      head :ok
    else
      render json: { errors: user.errors.full_messages }, status: 422
    end
  end

  private

  def user_params
    params.permit(:email, :name, :phone, :post, :password)
  end
end
