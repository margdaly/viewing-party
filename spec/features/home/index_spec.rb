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
    before :each do
      @user1 = create(:user)
      @user2 = create(:user)
      visit root_path
    end

    it 'a visitor cannot see a list of existing users' do
      expect(page).to_not have_content(@user1.email)
      expect(page).to_not have_content(@user2.email)
    end

    it 'a registered user can see a list of existing users' do
      @user3 = User.create!(name: 'Bob', email: 'b@email.com', password: '123', password_confirmation: '123')
      visit login_path
      fill_in :email, with: @user3.email
      fill_in :password, with: @user3.password
      click_button 'Log In'
      visit root_path

      expect(page).to have_content(@user1.email)
      expect(page).to have_content(@user2.email)
    end
  end
end