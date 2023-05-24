class UsersController < ApplicationController
  # skip_before_action :authenticate_user, only: [:new, :create]
  # before_action :redirect_if_authenticated, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  def show
    @user = User.find(session[:user_id])
  end
  
  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
