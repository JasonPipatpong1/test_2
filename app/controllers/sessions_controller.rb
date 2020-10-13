class SessionsController < ApplicationController
  # user shouldn't have to be logged in before logging in!
  skip_before_action :set_current_user
  skip_before_action :authenticate!

  def create
    auth=request.env["omniauth.auth"]
    user=Moviegoer.find_by(:provider => auth["provider"], :uid => auth["uid"]) || 
    # Moviegoer.create_with_omniauth(auth)
    unless user
      user = Moviegoer.create_with_omniauth(auth)
    end

    session[:user_id] = user.id
    redirect_to movies_path
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to movies_path
  end

end
