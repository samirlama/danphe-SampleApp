require 'rails_helper'
RSpec.feature "UserLogins", type: :feature do
  let(:user) { create(:user) }
  scenario "visit login page" do
    visit "/login" 
    expect(page).to have_content(/email/i)
    expect(page).to have_content(/password/i)
    expect(page). to have_content(/log in/i)
  end

  scenario "login successful" do
    visit "/login"
    within('form') do
      fill_in "session_email", with: user.email
      fill_in "session_password", with: user.password
    end
    click_button "Login"
    expect(page).to have_link("following")
    expect(page).to have_link("followers")
    expect(page). to have_content(user.following.count)
    expect(page).to have_content(user.followers.count)
  end

  scenario "login unsuccessful" do
    visit "/login"
    within('form') do
      fill_in "session_email", with: user.email
      fill_in "session_password", with: "asasdasd"
    end
    click_button "Login"
    expect(page).to have_content("Invalid email/password combination")
  end
end
