require 'rails_helper'

RSpec.feature "UserSignups", type: :feature do

  scenario "able to see the signup form" do 
  	visit('/signup')
  	expect(page).to have_content(/sign up/i)
  	expect(page).to have_content(/name/i)
  	expect(page).to have_content(/email/i)
  	expect(page).to have_content(/password/i)
  	expect(page).to have_content(/confirmation/i)
  end

  context "when user visits signup page" do
    scenario "should be able to signup" do
        visit new_user_path 
        within('form') do
          fill_in "user_name", with: "samir lama"
          fill_in "user_email", with: "smaiasdas@gmail.com"
          fill_in "user_password", with: "1221231"
          fill_in "user_password_confirmation", with: "1221231"
        end
        click_button 'Submit'
        expect(page).to have_content("Welcome samir lama to the sample App"); 
    end

    scenario "shouldnt be able to signup" do
      visit new_user_path
      within('form') do
        fill_in "user_name", with: " "
        fill_in "user_email", with: "smaiasdas@gmail.com"
        fill_in "user_password", with: "1221231"
        fill_in "user_password_confirmation", with: "12312312"
      end
      click_button "Submit"
      expect(page).to have_title('Sign Up')
      expect(page).to have_content("Name can't be blank")
    end
  end
end
