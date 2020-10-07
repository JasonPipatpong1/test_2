class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user, :authenticate!
   # prevents method from being invoked by a route
  def set_current_user
    # we exploit the fact that the below query may return nil
    @current_user = Moviegoer.find_by(:id => session[:user_id])
  end
  protected
  def authenticate!
    unless @current_user
        #redirect_to OmniAuth.login_path(:provider)
        redirect_to OmniAuth.login_path(:twitter)
        #redirect_to OmniAuth.login_path(:facebook)
    end
  end

end
