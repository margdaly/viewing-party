class MovieController < ApplicationController
  before_action :find_user, only: [:index, :results, :show]

  def index
  end

  def results
    @movies = MoviesFacade.new.get_results(params[:q])
  end

  def show
    @movie = MoviesFacade.new.get_movie(params[:movie_id])
    @cast = CastFacade.new.get_cast(params[:movie_id])
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