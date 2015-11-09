class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :redirect_to_login_page,  unless: :devise_controller?

  def current_account
    render json: { account: current_user.slice(:id, :display_name) }  
  end

  def redirect_to_login_page
    if current_user.nil?
      redirect_to new_user_session_path and return
    end
  end

  def after_sign_in_path_for(resource)
    root_path
  end
end
