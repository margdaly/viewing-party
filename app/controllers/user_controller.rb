class UserController < ApplicationController
  def new

  end

  def show
    @user = current_user
      if @user.nil?
        redirect_to root_path
        flash[:error] = "You must be logged in to view this page"
      end
  end
  
  def create
    user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        redirect_to user_path(user)
        flash[:notice] = "Welcome #{user.name}!"
      else
        flash[:notice] = "Registration Failed"
        render :new
      end
  end

  def login_form
  end

  def login
    user = User.find_by(params[:user_id])
    if user.authenticate(params[:password]) && user.email == params[:email]
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else 
      flash[:error] = "Login Failed"
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil 
    redirect_to root_path
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end