class ApplicationController < ActionController::Base

  UNPROCESSABLE_ENTITY_STATUS = 422
  OK_STATUS = 200
  NO_CONTENT_STATUS = 205

  ARTICLES_PAGINATION_LIMIT = 5
  USERS_PAGINATION_LIMIT = 5

  ## This makes current_user available also for the views
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if logged_in?
      flash[:warning] = 'You must be logged in to perform that action'
      redirect_to login_path
    end
  end

end
