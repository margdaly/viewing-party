class ViewingPartyController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @movie = MoviesFacade.new.get_movie(params[:movie_id])
    @viewingparty = ViewingParty.new
  end
end
