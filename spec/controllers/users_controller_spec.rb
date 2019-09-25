require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    let(:user) { create(:user) }
    let(:user1) { create(:user1) }
    let(:invalid_user) { FactoryBot.attributes_for(:user2, :invalid_email) } 
    let(:valid_user) { FactoryBot.attributes_for(:user2, :valid_email) }
    let!(:user_admin) { create(:user_admin) }
    let!(:user_admin1) { create(:user_admin) }
    let(:valid_session) { {user_id: user.id} }
    let(:user_admin_session) { {user_id: user_admin.id}}
    describe "GET #index" do
        context "when user is logged in" do
            before do
                session[:user_id] = user.id
            end
            it "renders index template" do
                get :index
                expect(response).to have_http_status(200)
            end
        end

        context "when user is not logged in" do
            it "should redirect to login url" do
                get :index
                expect(response).to redirect_to login_url
            end
        end
    end

    describe "GET #show" do
        context "when user is logged in" do  
            before(:each) do
                session[:user_id] = user.id
            end
            it "renders show page of correct user" do
                get :show, params:{ id: user.id } 
                expect(response).to be_success
            end 
        end
        context "when user is not logged in" do
            it "redirects to " do
                get :show, params: { id: user.id }
                expect(response).to redirect_to login_url
            end
        end
    end

    describe "POST #create" do
        context "when user is valid" do
            it "creates a new user" do
                expect{
                    post :create, params: {user: valid_user}
            }.to  change(User, :count).by(1)
            end
            it "redirects to root path" do
                post :create, params: {user: valid_user}
                expect(response).to redirect_to root_url
            end
        end

        context "when user is invalid" do
            it "doesnt reates a new user" do
                expect{
                    post :create, params: {user: invalid_user}
            }.to change(User, :count).by(0)
            end
            it "redirects to root path" do
                post :create, params: {user: invalid_user}
                expect(response).to render_template :new
            end
        end
    end

    describe "PUT #update" do
        context "when user is not logged in" do
            it "redirects to login url" do
                put :update, params: {id: user.id, user: valid_user }
                expect(response).to redirect_to login_url
            end
        end

        context "when user is logged in" do 
            context "when params are valid" do
                it "should update user" do
                    put :update, params: { id: user.id, user: valid_user}, session: valid_session
                    expect(response).to redirect_to user
                end
            end

            context "when params are invalid" do
                it "shouldnt update user" do
                    put :update, params: { id: user.id, user: invalid_user}, session: valid_session
                    expect(response).to render_template :edit
                end
            end
        end
    end

    describe "DELETE #destroy" do
        before do
            user
        end
        context "when user is admin" do
            it "can delete other user" do
                expect{
                    delete :destroy, params: {id: user.id}, session: user_admin_session
            }.to change(User, :count).by(-1)
            end

            it "cannot delete other admin" do
                expect{
                    delete :destroy, params: { id: user_admin1.id }, session: user_admin_session
            }.not_to change(User, :count)
            end
        end
    end
end
