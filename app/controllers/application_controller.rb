class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) {|u| u.permit(:name, :email, :birthday, 
      :password, :password_confirmation, :is_admin)}
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :birthday, 
      :password, :password_confirmation, :is_admin)}
  end
end
