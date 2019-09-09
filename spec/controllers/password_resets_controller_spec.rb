require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
    let(:user) { create(:user) }
    describe "POST #create" do
        context "when email is valid" do
            it "sends the password reest instruction" do
                post :create, params: { password_reset: {email: user.email }}
                expect(response).to redirect_to root_path 
            end
        end

        context "when email is invalid" do
            it "doesnt sneds passoword reset instruction" do
                post :create, params: { password_reset: {email: "123432@gmail.com"}}
                expect(response).to render_template :new
            end
        end
    end

    describe "PUT #update" do
    let(:user) { create(:user) }
        context "when password is empty" do
            it "doesnt not reset pasword and redirects to edit page" do
                put :update, params: { id: user.reset_token, email: user.email, user: { password: ''}}
                expect(response).to render_template :edit
            end
        end
        context "when password is valid" do
            it "updates password" do
                put :update, params: { id: user.reset_token, email: user.email, user: {password: "abcdefgh", password_confirmation: "abcdefgh"}}
                expect(response).to redirect_to user
            end
        end

        context "when password is invalid" do
            it "doesnt update password and redirecs to edit oage" do
                put :update, params: { id: user.reset_token, email: user.email, user: {password: "abcdefgh", password_confirmation: "abcdefg"}}
                expect(response).to render_template :edit
            end
        end
    end
end
