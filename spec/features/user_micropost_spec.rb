require 'rails_helper'

RSpec.feature "UserMicroposts", type: :feature do
  let(:user) { create(:user) }
  before do
    login(user)
    visit "/" 
  end
  context "when micropost field are submitted" do
      context "when picture is invalid" do
        scenario "errors are displayed" do
          within("form") do
            fill_in "micropost_content", with: "asdbasjkdhasjkhdjakshdjkashdadasdasgudas"
            attach_file("micropost_picture", Rails.root + "spec/fixtures/sample.pdf")
          end
          click_button "Post"
          expect(page).to have_content("You are not allowed to upload \"pdf\" file");
        end
        
        context "when picture is greater" do
          scenario " errors are displayed" do 
            within("form") do
              fill_in "micropost_content", with: "asdasdasdasdasdasdsdasdasdasdasdaeqweqweqweqweqweqweqwesd"
              attach_file("micropost_picture", Rails.root + "spec/fixtures/large-size.jpg")
            end
            click_button "Post"
            expect(page).to have_content("Picture should be less than 500 kilobyte");
          end  
        end

        context "content is blank" do
          scenario "errors are displayed" do
            within('form') do
              fill_in "micropost_content", with: " "
              attach_file("micropost_picture", Rails.root + "spec/fixtures/small-size.jpg")
            end
            click_button "Post"
            expect(page).to have_content("Content can't be blank")
          end
        end
      end

      context "when micropost is valid" do
        scenario "submitted successfully" do
          within('form') do
            fill_in "micropost_content", with: "asdsadasdukyasgdastdasugdausgdiuasdgasd"
            attach_file("micropost_picture", Rails.root + "spec/fixtures/small-size.jpg")
          end
          click_button "Post"
          expect(page).to have_content("Micropost created!")
        end
      end
  end
end