class AwardCategoriesController < ApplicationController

  def index
    render json: AwardCategory.select(:id, :title)
  end
end
