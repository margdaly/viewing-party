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

    scenario 'has link to return to home page' do
      within 'nav' do
        expect(page).to have_link('Home', href: root_path)
      end
    end

  describe 'links/buttons if not logged in' do
    scenario 'brand new user' do
      expect(page).to have_button('Create New User')

      click_button 'Create New User'

      expect(current_path).to eq('/register')
    end

    scenario 'user already has an account' do
      expect(page).to have_link('I already have an account')

      click_on 'I already have an account'

      expect(current_path).to eq('/login')
    end
  end

  describe 'list of existing users' do
    it "displays all existing users' emails as links to their dashboard" do
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      visit root_path

      within "#user-#{@user1.id}" do
        expect(page).to have_content(@user1.email)
      end

      visit root_path
      within "#user-#{@user2.id}" do
        expect(page).to have_content(@user2.email)
      end

      visit root_path
      within "#user-#{@user3.id}" do
        expect(page).to have_content(@user3.email)
      end
    end
  end
end