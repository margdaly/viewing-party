require 'rails_helper'

RSpec.describe MovieFacade do
  before :each do
    @movie = MoviesFacade.new.get_movie(238)
    @movie_facade = MovieFacade.new(@movie.id)
  end

  it 'initializes', :vcr do
    expect(@movie_facade).to be_a(MovieFacade)

    expect(@movie_facade.movie[:title]).to eq('The Godfather')
  end
end