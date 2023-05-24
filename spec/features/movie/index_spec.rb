require 'rails_helper'

RSpec.describe "Movie Index" do
  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit movie_index_path(@user)
  end

  it 'visits page' do
    expect(page).to have_content("Discover Movies")
    expect(current_path).to eq(movie_index_path(@user))
  end

  describe "top rated movies button" do
    it 'has button to search top rated movies', :vcr do
      expect(page).to have_button("Find Top Rated Movies")
      click_on("Find Top Rated Movies")
      expect(current_path).to eq(movie_results_path(@user))
    end
  end

  it "has a text field to enter keyword(s) to search by movie title", :vcr do
    expect(page).to have_field("q")
    expect(page).to have_button("Find Movies")
    click_on("Find Movies")
    expect(current_path).to eq(movie_results_path(@user))
  end
end