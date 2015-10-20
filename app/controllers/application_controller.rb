class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :redirect_to_login_page,  unless: :devise_controller?

  def redirect_to_login_page
    if current_user.nil?
      redirect_to new_user_session_page and return
    end
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end
end
