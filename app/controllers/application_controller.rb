class ApplicationController < ActionController::Base
  
  helper_method :current_user, :logged_in?
  def current_user
    # not very efficient. Has to query the db every time
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

end
