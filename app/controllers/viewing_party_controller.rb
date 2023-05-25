class ViewingPartyController < ApplicationController
  before_action :require_user

  def new
    @user = User.find(params[:user_id])
    @facade = MovieFacade.new(params[:movie_id])
  end

  private 

  def require_user
    if !session[:user_id]
      flash[:error] = 'You must be logged in or registered to create a viewing party'
      redirect_to movie_path(params[:user_id], params[:movie_id])
    end
  end
end
