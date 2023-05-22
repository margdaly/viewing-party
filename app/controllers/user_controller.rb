class UserController < ApplicationController
  def new

  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
    user = User.new(user_params)
      if user.save
        redirect_to user_path(user)
        flash[:notice] = "Welcome #{user.name}!"
      else
        flash[:notice] = "Registration Failed"
        render :new
      end
  end

  private
  def user_params
    params.permit(:name, :email, :password)
  end
end