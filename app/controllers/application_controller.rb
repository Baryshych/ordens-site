class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :restrict_access_to_admin_pages, unless: :devise_controller?

  def current_account
    render json: { account: current_user.slice(:id, :display_name) }  
  end

  def restrict_access_to_admin_pages
    if petitioner_signed_in?
      redirect_to petitions_path and return
    end
    if current_user.nil?
      redirect_to new_user_session_path and return
    end
  end

  def after_sign_in_path_for(resource)
    root_path
  end
end
