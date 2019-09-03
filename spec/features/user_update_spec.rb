require 'rails_helper'

RSpec.feature "UserUpdates", type: :feature do
  let(:user) { create(:user) }
  scenario "user visits edit page" do
    login(user)
    visit edit_user_path(user.id)
    expect(page).to have_content(/name/i)
    expect(page).to have_content(/email/i)
    expect(page).to have_content(/password/i)
    expect(page).to have_content(/confirmation/i)
    expect(page).to have_content(/update your profile/i)
  end
  
  context "when user visits edit page" do
    before(:each) do 
      login(user)
    end
    scenario "should be successful" do 
      visit edit_user_path(user.id)
      within('form') do
        fill_in "user_name", with: "samirasd"
        fill_in "user_email", with: "samirlama@gmail.com"
        fill_in "user_password", with: "123456"
        fill_in "user_password_confirmation", with: "123456"
      end
      click_button "Save Changes"
      expect(page).to have_content("Profile was edited successfully");
    end 

    scenario "shouldnt be successful" do
        visit edit_user_path(user.id)
        within ('form') do
          fill_in "user_name", with: " "
        end
        click_button "Save Changes"
        expect(page).to have_content("Name can't be blank")
    end
  end
end
