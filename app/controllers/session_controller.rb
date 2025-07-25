class SessionController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create, :signup]

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to root_path
    else
      flash.now[:error] = "There was something wrong with your login information"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to login_path
  end

  def signup
    if request.post?
      @user = User.new(username: params[:user][:username], password: params[:user][:password])
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Account created successfully!"
        redirect_to root_path
      else
        render 'signup'
      end
    else
      @user = User.new
    end
  end

  private

  def logged_in_redirect
    if logged_in?
      flash[:error] = "You are already logged in!"
      redirect_to root_path
    end
  end
end
