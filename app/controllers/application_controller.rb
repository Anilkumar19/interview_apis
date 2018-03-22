class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #for pundit authorization
   include Pundit
   #for csrf 
   protect_from_forgery with: :exception

  #for exception handling
  rescue_from StandardError, with: :standard_error
  #for authentication purpose
  before_filter :authenticate_user!


  #for standard error
  def standard_error(exception)
		# rescue StandardError => e
		logger.info "=============Error:: #{exception.inspect}========================="
		logger.info "=============Error:: #{exception.backtrace.join("\n")}========================="
		render json: {errors: "Something went wrong . please contact app developer"}, status: 500
  end
end
