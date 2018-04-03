class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #for pundit authorization
   include Pundit
   #for csrf 
   protect_from_forgery with: :exception

  #for exception handling
  #rescue_from StandardError, with: :standard_error
  #for authentication purpose
  before_filter :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?



  #for standard error
  def standard_error(exception)
		# rescue StandardError => e
		logger.info "=============Error:: #{exception.inspect}========================="
		logger.info "=============Error:: #{exception.backtrace.join("\n")}========================="
		render json: {errors: "Something went wrong . please contact app developer"}, status: 500
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
  
end
