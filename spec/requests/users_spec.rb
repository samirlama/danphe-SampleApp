require 'rails_helper'

RSpec.describe "Users", type: :request do
  include ApplicationHelper
  let(:user) { create(:user) }
  let(:user1) { create(:user1)}
  let(:invalid_user) { FactoryBot.attributes_for(:invalid_user)}

	describe "GET /users" do
		context "when user is not logged in" do 
			it "should redirect to login page" do
			  get users_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to login_url
			end
    end
  

		context "when user is logged in" do 
			it "should return success response" do 
				log_in_as(user)
				get users_path
				expect(response).to have_http_status(200)
			end
		end
  end

  describe "GET /users/:id" do
    context "when user is logged in" do
      it "should redirect to show page" do
        log_in_as(user)
        get user_path(user)
        expect(response).to have_http_status(200)
      end
    end

    context "when user is not logged in" do
      it "should redirect to root url" do
        get user_path(user)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to login_url
      end
    end
  end

   describe "GET /users/:id/edit" do
     context "when user is logged in" do
         it "should return success response" do
           log_in_as(user)
           get edit_user_path(user)
           expect(response).to have_http_status(200)
        end
     end

     context "when user is not loged in" do
       it "should redirect to login url" do
         get edit_user_path(user)
         expect(response).to redirect_to login_url
       end
     end

     context "when user tries to edit other user pages" do
        it "should not be able to to edit" do
          log_in_as(user)
          get edit_user_path(user1.id)  
          expect(response).to redirect_to edit_user(user)
          expect(respone).ro have_http_status(302)
        end 
     end
  end

  describe "GET /signup" do
    it "should return success responser" do
      get signup_path
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /user/:id" do 
    context "when user is not logged in" do 
    	it "should redirect to root_url" do
    		patch user_path(user), params: { user: user1 }
    		expect(response).to have_http_status(302)
      end
    end

    context "when user is logged in" do
      context "when user is valid" do
        it "should update user" do
          log_in_as(user)
          patch user_path(user), params: { user: FactoryBot.attributes_for(:user1)}
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(user_path(user))
        end
      end

      context "when attributes are invaliu" do
        it "shouldn't update user" do
          log_in_as(user)
          patch user_path(user), params: {user: { name: ''}}
          expect(response).to render_template :new
        end
      end
    end
  end

  describe "POST /signup" do
    context "when attributes are valid" do
      it "should redirect to root url" do
        post users_path, params: {user: FactoryBot.attributes_for(:user)}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(user_path(user))
      end
    end

    context "when attributes are invalid" do
      it "should render new" do
        post users_path, params: { user: invalid_user}
        expect(response).to render_template :new
      end
    end
  end

  describe "DELETE /users/:id" do
    context "when user i"
  end

end










