require 'rails_helper'

RSpec.describe "Users", type: :request do
  include ApplicationHelper
  let(:user) { create(:user, :user_activated) }
  let(:user1) { create(:user)}
  let(:invalid_user) { FactoryBot.attributes_for(:user, :invalid_email)}
  let(:valid_user) { FactoryBot.attributes_for(:user)}
  let(:user_admin) { create(:user, :user_admin, :user_activated) }
  let(:user_admin1) { create(:user, :user_admin, :user_activated) }
  
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
          expect(response).to redirect_to root_url
          expect(response).to have_http_status(302)
        end 
     end
  end

  describe "GET /signup" do
    it "should return success responser" do
      get signup_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /signup" do
    context "when attributes are valid" do
      it "should create user" do
        post "/users", params: { user: valid_user }
        expect(response).to redirect_to root_url
      end
    end 

    context "when attributes are invalid" do
      it "should not create user" do
        post users_path, params: { user: invalid_user }
        expect(response).to render_template :new
      end
    end
  end

  describe "GET /login" do
    it "should return success response" do
      get login_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /login" do
    context "when user is valid" do
      context "when user is activated" do
        it "should redirect to user show page" do
          post login_path, params: { session: { email: user.email, password: user.password}}
          expect(response).to redirect_to user_path(user)
        end
      end

      context "when user is not activated" do
        it "should redirect to root url" do
          post login_path, params: { session: {email: user1.email, password: user1.password}}
          expect(response).to redirect_to root_url
        end
      end
    end

    context "when user is invalid" do
      it "should render new" do
        post login_path, params: { session: { email: 122323, password: "2323234"}}
        expect(response).to render_template :new  
      end
    end
  end



  describe "PATCH /user/:id" do 
    context "when user is not logged in" do 
    	it "should redirect to root_url" do
    		patch user_path(user), params: { user: valid_user }
    		expect(response).to have_http_status(302)
      end
    end

    context "when user is logged in" do
      context "when user is valid" do
        it "should update user" do
          log_in_as(user)
          patch user_path(user), params: { user: valid_user}
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(user_path(user))
        end
      end

      context "when attributes are invalid" do
        it "shouldn't update user" do
          log_in_as(user)
          patch user_path(user), params: {user: { name: ''}}
          expect(response).to render_template :edit
        end
      end
    end
  end

  describe "POST /signup" do
    context "when attributes are valid" do
      it "should redirect to root url" do
        post users_path, params: {user: valid_user}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to root_url
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
    context "when user is not admin" do
      it "cant delete other user" do
        log_in_as(user)
        delete user_path(user1)
        expect(response).to have_http_status(302)
      end
    end

    context "when user is admin" do
      context "when admin tries to delete user" do
        it "should delete user" do
          log_in_as(user_admin)
          delete user_path(user)
          expect(response).to have_http_status(302)
          expect(User.count).to eq(1)
        end
      end
      context "when admin tries to delete other admin" do
        it " should not delete admin" do
          log_in_as(user_admin)
          delete user_path(user_admin1)
          expect(response).to have_http_status(302)  
        end
     end
    end
  end
end









