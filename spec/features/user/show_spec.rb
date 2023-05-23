require 'rails_helper'

RSpec.describe 'User Show Page' do
  before(:each) do
    @user_1 = User.create!(id: 1, name: 'Jimmy', email: 'jimmy@email.com', password: 'test', password_confirmation: 'test')
    @user_2 = User.create!(id: 2, name: 'Bobby', email: 'bobby@email.com', password: 'test', password_confirmation: 'test')

    visit '/users/1'
  end

  it "displays the user's name" do
    expect(page).to have_content("Jimmy's Dashboard")
    expect(page).to_not have_content("Bobby's Dashboard")
  end

  it 'has a button to Discover Movies, which redirectes to the discover page' do
    expect(page).to have_button('Discover Movies')
    click_button 'Discover Movies'
    expect(current_path).to eq("/users/#{@user_1.id}/discover")

    visit '/users/2'
    expect(page).to have_button('Discover Movies')
    click_button 'Discover Movies'
    expect(current_path).to eq("/users/#{@user_2.id}/discover")
  end

  it 'has section that lists viewing parties' do
    within 'section#viewing_parties' do
      expect(page).to have_content('Viewing Parties')
    end

    visit '/users/2'
    within 'section#viewing_parties' do
      expect(page).to have_content('Viewing Parties')
    end
  end
end