require 'rails_helper'

RSpec.describe 'Movie Results', :vcr do
  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe "user can click on Top Rated or Search and be taken to movie results page" do
    scenario "click on Top Rated Movies" do
      visit movie_index_path(@user)
      click_on "Find Top Rated Movies"
      
      expect(current_path).to eq(movie_results_path(@user))
      expect(page).to have_content("The Godfather")
    end

    describe "click on the Search button" do
      scenario "user doesn't enter a keyword into the text field" do
        visit movie_index_path(@user)
        click_on "Find Movies"

        expect(current_path).to eq(movie_results_path(@user))
        expect(page).to have_css(".movie", count: 0)
      end

      scenario "user enters a keyword into the text field" do
        visit movie_index_path(@user)
        fill_in :q, with: "ocean"
        click_on "Find Movies"

        expect(current_path).to eq(movie_results_path(@user))
        expect(page).to have_content("Ocean")
      end
    end
  end
end