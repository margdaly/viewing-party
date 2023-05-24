class Users::SessionsController < ApplicationController
  # skip_before_action :authenticate_user, only: [:new, :create]
  # before_action :redirect_if_authenticated, only: [:new, :create]

  def new
    #get login
  end

  def create
    #post login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Logged in successfully'
      redirect_to dashboard_path
    else
      flash[:error] = 'Sorry, your credentials are incorrect.'
      render :new
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
