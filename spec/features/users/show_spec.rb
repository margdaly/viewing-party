require 'rails_helper'

RSpec.describe 'User Show Page' do
  before(:each) do
    @user1 = User.create!(id: 1, name: 'Jimmy', email: 'jimmy@email.com', password: 'test', password_confirmation: 'test')
    @user2 = User.create!(id: 2, name: 'Bobby', email: 'bobby@email.com', password: 'test', password_confirmation: 'test')
    visit login_path
    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password
    click_on 'Log In'
    # visit dashboard_path
  end

  it "displays the user's name" do
    expect(page).to have_content("Jimmy's Dashboard")
    expect(page).to_not have_content("Bobby's Dashboard")
  end

  it 'has a button to Discover Movies, which redirectes to the discover page' do
    expect(page).to have_button('Discover Movies')
    click_button 'Discover Movies'
    expect(current_path).to eq("/users/#{@user1.id}/discover")
  end

  it 'has section that lists viewing parties' do
    within 'section#viewing_parties' do
      expect(page).to have_content('Viewing Parties')
    end
  end

  describe 'visting dashboard as a visitor' do
    it 'redirects to landing page' do
      click_on 'Log Out'
      expect(current_path).to eq(root_path)
      visit dashboard_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content('must be logged in or registered')
    end
  end
end