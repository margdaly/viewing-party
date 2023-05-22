require 'rails_helper'


describe "User Creation" do
   it 'creates users' do
   create_list(:user, 5)
  
   expect(User.count).to eq(5)
 end
end
