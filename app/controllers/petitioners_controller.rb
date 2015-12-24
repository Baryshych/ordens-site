class PetitionersController < ApplicationController
  before_filter :authenticate_user!, except: :test

  def index
    render json: Petitioner.select(:id, :name, :email).all
  end

end
