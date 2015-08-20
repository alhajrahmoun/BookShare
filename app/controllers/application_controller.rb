class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :username, :gender, :country, :birthday, :image) }
   end

  def after_sign_in_path_for(resource)
    # return the path based on resource
    home_index_path
  end

  def after_sign_out_path_for(resource)
    # return the path based on resource
    "/welcome"
  end
end
