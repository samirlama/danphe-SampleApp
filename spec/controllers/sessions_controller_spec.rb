require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    let(:user) { create(:user) }
    describe "POST #create" do
        context "when user is valid" do
            it "should login" do
                post :create, params: { session: {email:user.email, password: user.password, password_confirmation: user.password_confirmation} }
                expect(response).to redirect_to user
            end
        end

        context "when user is invalid" do
            it "shouldn't login" do
                post :create, params: {session: {email: "123112"}}
                expect(response).to render_template :new
            end
        end
    end

    describe "DELETE #destroy" do
        let(:user) { create(:user) }
        before do
            session[:user_id] = user.id        
        end
        it "logs out user" do
            delete :destroy
            expect(response).to redirect_to root_url
            expect(session[:user_id]).to be_nil
        end
    end
end
