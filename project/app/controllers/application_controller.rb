class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar])
  end

  def authenticate_admin?
    unless current_user.role == 'admin'
      flash[:alert] = "you are not administer"
      redirect_back fallback_location: root_path
    end
  end

end
