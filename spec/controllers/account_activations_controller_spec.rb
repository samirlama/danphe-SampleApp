require 'rails_helper'

RSpec.describe AccountActivationsController, type: :controller do
    let(:user) { create(:user, activated: false) }
    describe "GET #edit" do
        context "when user is valid" do
            it "activates account" do
                get :edit, params: { id: user.activation_token, email: user.email }
                expect(response).to redirect_to user
            end
        end

        context "when user is invalid" do
            it "doesnt activates account" do
                get :edit, params: {id: user.activation_token, email: "123@gmail.com"}
                expect(response).to redirect_to root_url
            end
        end
    end
end
