require 'rails_helper'

RSpec.describe 'User Login form' do
  it 'happy path' do
    new_user = User.create(name: 'Newer User', email: 'neweruser321@email.com', password: 'test' )

    visit login_form_path

    fill_in :email, with: 'neweruser321@email.com'
    fill_in :password, with: 'test'

    click_button 'Login'

    expect(current_path).to eq(user_path(new_user))
  end

  describe 'sad path' do
    it 'wrong email' do
      new_user = User.create(name: 'Newer User', email: 'neweruser321@email.com', password: 'test' )
  
      visit login_form_path
  
      fill_in :email, with: 'neweruser123@mail.notcorrectemail'
      fill_in :password, with: 'test'
      
      click_button 'Login'

      expect(page).to have_content("Login Failed")
      expect(current_path).to eq(login_path)
    end
    it 'wrong password' do
      new_user = User.create(name: 'Newer User', email: 'neweruser321@email.com', password: 'test' )
  
      visit login_form_path
  
      fill_in :email, with: 'neweruser123@mail.com'
      fill_in :password, with: 'test but incorrectly'
      
      click_button 'Login'

      expect(page).to have_content("Login Failed")
      expect(current_path).to eq(login_path)
    end
  end
end