class RegistrationsController < Devise::RegistrationsController
  after_filter :log_out, only: :new


  protected

  def log_out
    sign_out :user
  end

  def sign_up_params
  	params.require(:user).permit(
  		:first_name,
  		:last_name,
  		:profile_name,
  		:email,
  		:password,
  		:password_confirmation)
  end
end