require 'rails_helper'

RSpec.describe 'User Registration' do
  describe 'creates new user' do
    scenario 'happy path' do
      visit register_path

      fill_in 'Name', with: 'User One'
      fill_in 'Email', with: 'user1@example.com'
      fill_in 'Password', with: '123password'
      fill_in 'Password confirmation', with: '123password'

      click_button 'Create New User'

      expect(current_path).to eq(user_path(User.last.id))
      expect(page).to have_content("User One's Dashboard")
    end

    scenario 'sad path, email isnt unique' do
      User.create(name: 'User One', email: 'notunique@example.com', password: '123password', password_confirmation: '123password')

      visit register_path

      fill_in 'Name', with: 'User Two'
      fill_in 'Email', with: 'notunique@example.com'
      fill_in 'Password', with: '123password'
      fill_in 'Password confirmation', with: '123password'
      click_button 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content('Email has already been taken')
    end

    scenario 'sad path, passwords dont match' do
      visit register_path

      fill_in 'Name', with: 'User'
      fill_in 'Email', with: 'unique@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: '123password'

      click_button 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password confirmation doesn't match")
    end

    scenario 'sad path, no name' do
      visit register_path

      fill_in 'Name', with: ''
      fill_in 'Email', with: 'unique@example.com'
      fill_in 'Password', with: '123password'
      fill_in 'Password confirmation', with: '123password'

      click_button 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Name can't be blank")
    end
  end
end