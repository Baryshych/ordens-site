class PetitionsController < ApplicationController
  skip_before_filter :restrict_access_to_admin_pages
  before_filter :authenticate_petitioner!, except: :test
  before_filter :confirmation_notice, except: :new

  def index
    if params[:search]
      @petitions = current_petitioner.petitions.search(params[:search])
    else
      @petitions = current_petitioner.petitions
    end
  end

  def new
    unless current_petitioner.confirmed_at?
      render 'petitioners/confirm_email'
      return
    end
    @petition = Petition.new
  end

  def edit
    @petition = current_petitioner.petitions.find(params[:id])
    if @petition.status != Petition::NEW
      flash[:warning] = 'Ви не можете редагувати запис, адміністратор змінив статус.'
      redirect_to petitions_path
      return
    end
    flash.now[:notice] = 'Ви можете редагувати запис тільки якщо адміністратор ще не змінив його статус'
  end

  def create
    @petition = Petition.new(petition_params)
    @petition.petitioner_id = current_petitioner.id
    if @petition.save
      redirect_to petitions_path, notice: 'Заявку успішно додано'
    else
      flash.now[:danger] = @petition.errors.full_messages
      render 'petitions/new'
    end
  end

  def update
    @petition = current_petitioner.petitions.find(params[:id])
    if @petition.status != Petition::NEW
      flash[:warning] = 'Ви не можете редагувати запис, адміністратор змінив статус.'
      redirect_to petitions_path
      return
    end
    @petition.assign_attributes(petition_params)
    if @petition.save
      redirect_to petitions_path, notice: 'Заявку успішно оновлено'
    else
      flash.now[:danger] = @petition.errors.full_messages
      render 'petitions/edit'
    end
  end

  private

  def confirmation_notice
    if current_petitioner.confirmed_at.nil?
      flash.now[:alert] = "Ви не підтвердили електронну адресу. 
      Необхідно підтвердити адресу для повної функціональності."
    end
  end

  def petition_params
    params.require(:petition).permit(
      :last_name, :first_name, :middle_name, :born_at, :male, :nationality,
      :home_phone, :home_address, :archievements, :workplace, :post,
      :party_membership, :education, :science_degree_id, :education_degree_id,
      :special_degree, :workplace_address, :work_phone, :years_worked_total,
      :years_worked_on_current_place, :award_id, :award_cause, :comment
    )
  end
end
