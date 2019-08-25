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

        context "when correct user" do  
            before(:each) do
                session[:user_id] = user_1.id
            end
            it "renders show page of correct user" do
                get :show, params:{ id: user_1.id } 
                expect(response).to be_success
            end 
        end
        context "when incorrect user" do
            before(:each) do
                session[:user_id] = user_1.id
            end
            it "renders show page of own" do
                get :show, params: { id: user_2.id }
                expect(response).to redirect_to(user_1)
            end
        end

    end
    
    describe "POST #create" do
        let(:user) {FactoryBot.attributes_for(:user)}
        let(:invalid_user) {FactoryBot.attributes_for(:user, email: 12323)}
        context "when user is invalid" do
            it "doesnt creates a new user" do
                expect{
                    post :create, params: {user: invalid_user}
            }.to  change(User, :count).by(0)
            end
            it "redirects to root path" do
                post :create, params: {user: invalid_user}
                expect(response).to redirect_to root_path
            end
        end
        # context "if user are valid" do
            
        #     it " creates a new user" do
        #         expect{
        #             post :create, params: {user: FactoryBot.attributes_for(:user, activated: true)}
        #     }.to  change(User, :count).by(1)
        #     end
        #     it "redirects to root path" do
        #         post :create, params: {user: FactoryBot.attributes_for(:user)}
        #         expect(response).to redirect_to user
        #     end
        # end

    end

    describe "PUT #update" do
        let!(:user_1) {FactoryBot.create(:user)}
        # let!(:user_2) { create(:user) }
        # context "if attributes are valid" do 
        #     before do
        #         session[:user_id] = user_1.id
        #     end
        #     it "updates post" do 
        #         put :update, params: {id: user_1.id, user: FactoryBot.attributes_for(:user, email:"samir@gmail.comm", name: "samirdas")}
        #         user_1.reload
        #         expect(user_1.name).to eq("samirdas")
        #     end
        #     it "redirects to user" do
        #         put :update,params: {id: user_1.id, user: FactoryBot.attributes_for(:user, email: "sasdasdgh@gmail.com", name: "samirdas")}
        #         expect(response).to redirect_to user_1
        #     end
        # end

        context "when user is valid" do
            before do 
                session[:user_id] = user_1.id
            end 
            context "when attributes are valid" do
                it "doesnt update post" do
                    put :update, params: {id: user_1.id, user: FactoryBot.attributes_for(:user, email: 2131231, name: "samirdas")}
                    user_1.reload
                    expect(user_1.name).to_not eq("samirdas")
               end
               it "redire"            
            end
            context "when attributes are valid" do
           it "redirect to new" do
                put :update, params: {id: user_1.id, user: FactoryBot.attributes_for(:user, email: "sasdasdghgmail.com", name: "samirdas")}
                expect(response).to render_template :new
           end
        end

    end
end
