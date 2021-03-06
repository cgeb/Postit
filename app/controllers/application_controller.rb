class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if !!logged_in?
  end

  def logged_in?
    session[:user_id]
  end

  def require_user
    if !logged_in?
      flash[:error] = "You need to be logged in to do this."
      redirect_to root_path
    end
  end

  def require_admin
    if !logged_in? || !current_user.admin?
      flash[:error] = "You can't do that."
      redirect_to root_path
    end
  end
end
