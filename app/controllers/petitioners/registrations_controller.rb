class Petitioners::RegistrationsController < Devise::RegistrationsController
 
  before_filter :configure_permitted_parameters

  def new
    @petitioner = Petitioner.new
    render 'petitioners/sign_up'
  end

  def create
    super do
      if resource.errors.any?
        flash[:danger] = resource.errors.full_messages
        @petitioner = resource
        render 'petitioners/sign_up' 
        return
      end
    end
  end

  def after_sign_up_path_for(resource)
    petitions_path
  end

  def after_sign_in_path_for(resource)
    petitions_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :phone, :post, :workplace, :address, :email, :password, 
               :password_confirmation)
    end
  end
end
