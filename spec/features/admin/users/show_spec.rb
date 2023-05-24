require 'rails_helper'

RSpec.describe "admin dashboard" do
  describe 'happy path' do
    before :each do
      @admin_user = User.create!(name: "Bob the Admin", email: "adminbob@email.com", password: "AdminMan", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
      @user_1 = create(:user)
      @user_2 = create(:user)
      @user_3 = create(:user)
      @user_4 = create(:user)
      @user_5 = create(:user)

      visit admin_dashboard_path
      click_on @user_1.email
    end

    it 'visits user show page' do
      expect(current_path).to eq(admin_user_show_path(@user_1))
    end

    it 'displays the user name' do
      expect(page).to have_content(@user_1.name)
      expect(page).to_not have_content(@user_2.name)
    end

    it 'has a button to discover movies' do
      expect(page).to have_button('Discover Movies')
      click_button 'Discover Movies'
      expect(current_path).to eq("/discover")
    end

    it 'has a section that lists viewing parties' do
      within 'section#viewing_parties' do
        expect(page).to have_content('Viewing Parties')
      end
    end
  end

  describe 'sad path' do
    it 'cannot be accessed by default user' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_dashboard_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end