require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "GET #index" do
       it "assigns user where activated is true" do
            users = User.where(activated: true).all
            expect(@users.to_a).to eq(users.to_a)
        end
        it "renders index template" do
            get :index
            expect(response).to render_template :index
        end
    end

    describe "GET #show" do
        let(:user_1) { FactoryBot.create(:user) }
        let(:user_2) {FactoryBot.create(:user, email: "asdasdas@gmail.com")}
       
        context "when user is logged in" do  
            before(:each) do
                session[:user_id] = user_1.id
            end
            it "renders show page of correct user" do
                get :show, params:{ id: user_1.id } 
                expect(response).to be_success
            end 
        end
        context "when user is not logged in" do
            it "redirects to " do
                get :show, params: { id: user_2.id }
                expect(response).to redirect_to(user_1)
            end
        end
    end

    describe "POST #create" do
        let(:user) { FactoryBot.attributes_for(:user) }
        let!(:invalid_user) { FactoryBot.attributes_for(:invalid_user) }
        context "when user is valid" do
            it "creates a new user" do
                expect{
                    post :create, params: {user: user}
            }.to  change(User, :count).by(1)
            end
            it "redirects to user path" do
                post :create, params: {user: user}
                expect(response).to have_http_status(302)
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
        let(:user) { create(:user)}
        let(:user1) { create(:user1) }
        let(:valid_session) { {user_id: user.id} }
        context "when user is not correct" do
            it "redirect_to current_user" do
                put :update, params: {id: user1.id, user: FactoryBot.attributes_for(:user) },session: valid_session 
                expect(response).to redirect_to user
            end
        end
        context "when attributes are valid" do 
            it "redirects to user" do
                put :update,params: {id: user.id, user: FactoryBot.attributes_for(:user, email: "samir@gmail.com")}, session: valid_session
                expect(response).to redirect_to user
            end
        end
     
        context "when user is invalid" do
             it "redirect to new" do
                 put :update, params: {id: user.id, user: FactoryBot.attributes_for(:user1, email: "111111")}, session: valid_session
                 expect(response).to render_template :new
             end
        end
    end

    describe "DELETE #destroy" do
        let!(:user_admin) { create(:user_admin) }
        let!(:user_admin1) { create(:user_admin1) }
        let!(:user) { create(:user) }
        let(:user_admin_session) { {user_id: user_admin.id}}
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
