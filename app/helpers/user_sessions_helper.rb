module UserSessionsHelper

  def login_user(user)
    session[:user_id] = user.id
  end

  def logout_user
    if logged_in?
      forget_current_user
      session.delete(:user_id)
    end
  end

  # If we want to remember user, this user must be logged in, so that, we no need user for parram for this method,
  def remember_current_user
    if logged_in?
      current_user.remember
      cookies.permanent.signed[:user_id] = current_user.id
      cookies.permanent[:remember_token] = current_user.remember_token
    end
  end

  def forget_current_user
    if logged_in?
      current_user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.remember_token_valid?(cookies[:remember_token])
        @current_user = user
        login_user user
      end
    end
  end

  def current_user?(user)
    current_user == user
  end

  def logged_in?
    !current_user.nil?
  end
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
