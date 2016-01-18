class UserSessionsController < ApplicationController

  def new

  end

  def create
    posted_params = login_params
    user = User.find_by(email: posted_params[:email])
    if !user
      flash[:error] = "This email is not exist"
      render :new
    elsif user.authenticate(posted_params[:password])
      @user = user
      if posted_params[:remember_me] == '1'
        login_user  @user
        remember_current_user
      else
        login_user @user
        forget_current_user
      end
      flash[:success] = "Login success"
      redirect_to @user
    else
      flash[:error] = "Password is not valid"
      render :new
    end
  end

  def destroy
    if logged_in?
      logout_user
      flash[:success] = "Logout success"
    end
    redirect_to root_path
  end
  private
    def login_params
      params.require(:login).permit(:email, :password, :remember_me)
    end
end
