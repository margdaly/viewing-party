require 'rails_helper'

RSpec.describe 'Logging Out' do
  scenario 'happy path' do
    user = User.create(name: 'Tammy', email: 'funbucket13@email.com', password: 'test', password_confirmation: 'test')

    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log In'

    expect(page).to have_link("Log Out")
    expect(page).to_not have_link('Log In')

    click_on 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to_not have_link("Log Out")

    expect(page).to have_link('I already have an account')
    expect(page).to have_button('Create New User')
  end
end