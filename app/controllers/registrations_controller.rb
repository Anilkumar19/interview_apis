class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate_user!

  protected

  def after_sign_up_path_for(resource)
    UserMailer.welcome_user(resource).deliver
    super
  end
end