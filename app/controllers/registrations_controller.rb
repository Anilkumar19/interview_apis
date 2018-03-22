class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate_user!

  protected
   #after siugn up path
  def after_sign_up_path_for(resource)
  	#for sending sign 
    UserMailer.welcome_user(resource).deliver
    super
  end
end