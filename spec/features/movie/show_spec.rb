require 'rails_helper'

RSpec.describe 'Movie Show' do
  before :each do
    @user = create(:user)
    @movie = MoviesFacade.new.get_movie(238)

    visit "/users/#{@user.id}/movies/#{@movie.id}"
  end 

  it "has button to create viewing party", :vcr do  
    expect(page).to have_button("Create Viewing Party For The Godfather")

    click_on("Create Viewing Party For The Godfather")
    expect(current_path).to eq(new_viewing_party_path(@user, @movie))
  end

  it "has a button to return to discover page", :vcr do
    expect(page).to have_button("Discover Movies")

    click_on("Discover Movies")
    expect(current_path).to eq(movie_index_path(@user))
  end

  it "displays movie's details", :vcr do
  end
end