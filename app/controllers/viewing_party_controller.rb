class ViewingPartyController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @movie = MovieFacade.new(params[:movie_id])
    @viewingparty = ViewingParty.new
  end
end