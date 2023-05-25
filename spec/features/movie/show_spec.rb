require 'rails_helper'

RSpec.describe 'Movie Show', :vcr do
  before :each do
    @user = create(:user)
    @movie = MoviesFacade.new.get_movie(238)
    @cast = CastFacade.new.get_cast(238)
    visit login_path
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_on 'Log In'

    visit "/users/#{@user.id}/movies/#{@movie.id}"
  end 
  
  describe "button section" do
    it "has button to create viewing party" do  
      expect(page).to have_button("Create Viewing Party For The Godfather")

      click_on("Create Viewing Party For The Godfather")
      expect(current_path).to eq(new_viewing_party_path(@user, @movie.id))
    end

    it "wont create viewing party if not logged in" do
      click_on 'Log Out'
      visit "/users/#{@user.id}/movies/#{@movie.id}"

      expect(page).to have_button("Create Viewing Party For The Godfather")

      click_on("Create Viewing Party For The Godfather")
      expect(current_path).to eq("/users/#{@user.id}/movies/#{@movie.id}")
      expect(page).to have_content('You must be logged in or registered to create a viewing party')
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
      expect(page).to have_content("Vote Average: 8.7")
      expect(page).to have_content("Runtime: 2 hours 55 minutes")
      expect(page).to have_content("Genres: Drama, Crime")
      expect(page).to have_content("Summary: Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.")
    end

    it "displays movie's cast and characters" do
      expect(page).to have_content("Name: Al Pacino")
      expect(page).to have_content("Character: Michael Corleone")
      expect(page).to have_content("Name: Marlon Brando")
      expect(page).to have_content("Character: Vito Corleone")
      expect(page).to have_content("Name: James Caan")
      expect(page).to have_content("Character: Sonny Corleone")
      expect(page).to have_content("Name: Richard S. Castellano")
      expect(page).to have_content("Character: Peter Clemenza")
      expect(page).to have_content("Name: Robert Duvall")
      expect(page).to have_content("Character: Tom Hagen")
    end

    it "displays the movie's reviews" do
      expect(page).to have_content("Author: futuretv\nReview:")
    end

    it 'countes reviews' do
      expect(page).to have_content("Review Count: 3")
    end
  end
end