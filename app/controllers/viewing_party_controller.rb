class ViewingPartyController < ApplicationController
  before_action :find_user, only: [:new]
  def new
    @movie = MoviesFacade.new.get_movie(params[:movie_id])
    @viewingparty = ViewingParty.new
  end

  private
    def find_user
      @user = current_user
        if current_user.nil?
          redirect_to root_path
          flash[:error] = "You must be logged in to view this page"
        end
    end
end
