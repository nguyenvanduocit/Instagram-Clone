class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include UserSessionsHelper
  private
  def filter_logged_in
    unless logged_in?
      store_location
      flash[:danger] = 'You have to login to access this page'
      redirect_to login_path
    end
  end

  def filter_not_logged_in
    if logged_in?
      flash[:danger] = 'you can not access this page'
      redirect_to root_path
    end
  end

  def filter_owner
    unless current_user? @user
      flash[:danger] = "You have not permission"
      redirect_to root_path
    end
  end
end
