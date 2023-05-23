require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do
    visit root_path
  end

  scenario "displays title of Application" do
    within 'header#title' do
      expect(page).to have_content("Viewing Party")
    end
  end

  scenario "has link to return to home page" do
    within 'nav' do
      expect(page).to have_link('Home', href: root_path)
    end
  end

  scenario "has button to create new user" do
    within "#create_user" do
      expect(page).to have_button("Create New User")
      click_button "Create New User"
    end
    expect(current_path).to eq("/register")
  end

  describe "list of existing users" do
    it "displays all existing users' emails as links to their dashboard" do
      @user_1 = create(:user)
      @user_2 = create(:user)
      @user_3 = create(:user)
      visit root_path

      within "#user-#{@user_1.id}" do
        expect(page).to have_link("#{@user_1.email}")
        click_on "#{@user_1.email}"
        expect(current_path).to eq("/users/#{@user_1.id}")
      end

      visit root_path
      within "#user-#{@user_2.id}" do
        expect(page).to have_link("#{@user_2.email}")
        click_on "#{@user_2.email}"
        expect(current_path).to eq("/users/#{@user_2.id}")
      end

      visit root_path
      within "#user-#{@user_3.id}" do
        expect(page).to have_link("#{@user_3.email}")
        click_on "#{@user_3.email}"
        expect(current_path).to eq("/users/#{@user_3.id}")
      end
    end
    scenario 'Login link' do
      visit root_path
      within "#login" do
        expect(page).to have_link("Login")
        click_link("Login")
      end
      expect(current_path).to eq(login_form_path)
    end

    scenario 'Logout link' do
      new_user = User.create(name: 'Newer User', email: 'neweruser321@email.com', password: 'test' )

      visit login_form_path
  
      fill_in :email, with: 'neweruser321@email.com'
      fill_in :password, with: 'test'
  
      click_button 'Login'

      visit root_path
      expect(page).to have_link("Logout")
      click_link("Logout")
      expect(current_path).to eq(root_path)
      expect(page).to have_link("Login")
    end
  end
end