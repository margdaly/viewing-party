require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do
    visit root_path
  end

  scenario 'displays title of Application' do
    within 'header#title' do
      expect(page).to have_content('Viewing Party')
    end
  end

  describe 'links/buttons' do
    scenario 'has link to return to home page' do
      within 'nav' do
        expect(page).to have_link('Home', href: root_path)
      end
    end

    scenario 'has button to create new user' do
      within '#create_user' do
        expect(page).to have_button('Create New User')
        click_button 'Create New User'
      end
      expect(current_path).to eq('/register')
    end

    
  end

  describe 'list of existing users' do
    it "displays all existing users' emails as links to their dashboard" do
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      visit root_path

      within "#user-#{@user1.id}" do
        expect(page).to have_link(@user1.email)
        click_on @user1.email
        expect(current_path).to eq("/users/#{@user1.id}")
      end

      visit root_path
      within "#user-#{@user2.id}" do
        expect(page).to have_link(@user2.email)
        click_on @user2.email
        expect(current_path).to eq("/users/#{@user2.id}")
      end

      visit root_path
      within "#user-#{@user3.id}" do
        expect(page).to have_link(@user3.email)
        click_on @user3.email
        expect(current_path).to eq("/users/#{@user3.id}")
      end
    end
  end
end