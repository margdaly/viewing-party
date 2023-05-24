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
    end

    it 'can see all users' do 
    
      within "#users-#{@user_1.id}" do
        expect(page).to have_content(@user_1.name)
        expect(page).to have_content(@user_1.email)
      end

      within "#users-#{@user_2.id}" do
        expect(page).to have_content(@user_2.name)
        expect(page).to have_content(@user_2.email)
      end

      within "#users-#{@user_3.id}" do
        expect(page).to have_content(@user_3.name)
        expect(page).to have_content(@user_3.email)
      end

      within "#users-#{@user_4.id}" do
        expect(page).to have_content(@user_4.name)
        expect(page).to have_content(@user_4.email)
      end

      within "#users-#{@user_5.id}" do
        expect(page).to have_content(@user_5.name)
        expect(page).to have_content(@user_5.email)
      end
    end
    xit 'clicks on a user and is taken to their dashboard' do
      click_on @user_1.name

      expect(current_path).to eq(admin_user_path(@user_1))
    end
  end
end