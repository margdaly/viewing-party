require 'rails_helper'

RSpec.describe 'ViewingParty new page' do
  before :each do
    @user = User.create(name: 'Carlos', email: 'Carlos Email')
    @movie = MoviesFacade.new.get_movie(238)
    visit new_viewing_party_path(@user.id, @movie.id)
  end

  describe 'form' do
    xit 'happy path',:vcr do
      fill_in 
    end

    xit 'sad path',:vcr do
      
    end
  end
end