require 'rails_helper'

RSpec.describe 'Movie Show', :vcr do
  before :each do
    @user = create(:user)
    @movie = MoviesFacade.new.get_movie(238)
    @cast = CastFacade.new.get_cast(238)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit "/movies/#{@movie.id}"
  end 
  
  describe "button section" do
    it "has button to create viewing party" do  
      expect(page).to have_button("Create Viewing Party For The Godfather")

      click_on("Create Viewing Party For The Godfather")
      expect(current_path).to eq(new_viewing_party_path(@user.id, @movie))
    end

    it "has a button to return to discover page" do
      expect(page).to have_button("Discover Movies")

      click_on("Discover Movies")
      expect(current_path).to eq(movie_index_path(@user))
    end
  end

  describe "general info section" do
    it "displays movie's details" do
      expect(page).to have_content("The Godfather")
      expect(page).to have_content("Vote: 8.7")
      expect(page).to have_content("Runtime: 2 hours 55 minutes")
      expect(page).to have_content("Genre: Drama, Crime")
      expect(page).to have_content("Summary: Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.")
    end
    
    it "displays movie's cast and characters" do
      expect(page).to have_content("Cast: Al Pacino, ")
    end

    it "displays the movie's reviews" do  
    # expect(page).to have_content("Reviews:")
    # expect(page).to have_content("Author: ")
    end
  end
end