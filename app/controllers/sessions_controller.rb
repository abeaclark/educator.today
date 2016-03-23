class SessionsController < ApplicationController

  def create
    begin
    @user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = @user.id
    flash[:success] = "Welcome, #{@user.name}!"
    rescue => error
      flash[:warning] = "There was an error while trying to authenticate you..."
      p error.backtrace
    end
    redirect_back_or_default
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'See you!'
    end
    redirect_to root_path
  end

  def redirect_back_or_default
      redirect_to(session[:return_to] || root_path)
      session[:return_to] = nil
  end

end
