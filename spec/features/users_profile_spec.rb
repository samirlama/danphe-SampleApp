require 'rails_helper'

RSpec.feature "UsersProfile", type: :feature do
  let(:user) { create(:user) }
  let(:user1) { create(:user1) }
  let(:micropost) { create(:micropost, user: user) }
  subject(:relationship) { Relationship.create(followed_id: user1.id, follower_id: user.id) }
 
  scenario "able to see the user profile" do 
  	visit(user_path(user))
  	expect(page).to have_content(user.name)
  	expect(page).to have_content(user.followers.count)
  	expect(page).to have_content(user.following.count)
  end

  context "when user has posts" do 
    before do 
      micropost
    end
  	scenario "should sees the microposts" do
  		visit(user_path(user))
	  	expect(page).to have_content('Microposts')
	  	expect(page).to have_content(micropost.content)
  	end
  end

  context "when visitor is logged in" do
    context "when visitor has been followed" do
      before do 
        login(user)  
        relationship
        visit(user_path(user1)) 
      end
  	  scenario "should see the unfollow button" do 
  		  expect(page).to have_selector(:link_or_button, 'Unfollow')
      end
    end 
    
    context "when visitor has not been followed" do
      before do 
        login(user)  
        visit(user_path(user1)) 
      end
  	  scenario "should see the follow button" do 
  		  expect(page).to have_selector(:link_or_button, 'Follow')
      end
    end  

    context "when visitor follows the user" do 
      before do 
        login(user)  
        visit(user_path(user1)) 
      end
      scenario "button changes from follow to unfollow" do 
  			click_button 'Follow'
  			expect(page).to have_selector(:link_or_button, 'Unfollow')
  		end
  	end

    context "when visitor unfollows the user" do 
      before do 
        login(user)
        relationship 
        visit(user_path(user1))
      end
  		scenario "button changes from unfollow to follow" do
  			click_button 'Unfollow'
  			page.should have_selector(:link_or_button, 'Follow')
  		end
  	end
  end
end

