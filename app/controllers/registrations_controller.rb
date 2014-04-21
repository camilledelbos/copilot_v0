class RegistrationsController < Devise::RegistrationsController
  after_filter :log_out, only: :new

# if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        logging_in
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user
    begin
      # Cache the value the first time it's gotten.
      @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
      sign_in(:user, @cached_guest_user)

     rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
       session[:guest_user_id] = nil
       guest_user
     end
  end

  protected

  def log_out
    sign_out :user
  end

  # def sign_up_params
  # 	params.require(:user).permit(
  # 		:first_name,
  # 		:last_name,
  # 		:profile_name,
  # 		:email,
  # 		:password,
  # 		:password_confirmation)
  # end
end