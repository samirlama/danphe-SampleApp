require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
    describe "POST #create" do
        let(:user) { create(:user) }
        let(:micropost) { FactoryBot.attributes_for(:micropost, :valid_content) }
        let(:invalid_micropost) { FactoryBot.attributes_for(:micropost, :invalid_content) }
        let(:valid_session) { {user_id: user.id} }
        context "when user is not logged in" do
            it "redirect_to root path" do
                post :create, params: {micropost: micropost}
                expect(response).to redirect_to root_path
            end
        end
        context "when micropost is valid" do
            it "redirects to root url" do
                post :create, params: {micropost: micropost}, session: valid_session
                expect(response).to redirect_to root_url
            end
        end
        context "when micropost in invalid" do
            it "renders home of static pages" do
                post :create, params: {micropost: invalid_micropost}, session: valid_session
                expect(response).to render_template("static_pages/home")
            end
        end
    end

    describe "DELETE #destroy" do
        let(:user) { create(:user) }
        let(:valid_session) { {user_id: user.id} }
        let(:micropost) { create(:micropost, user_id: user.id) }
        context "when user has doesnt have micropost" do
            it "redirects to request referrer or rool url" do
                delete :destroy, params: { id: 2 }, session: valid_session
                expect(response).to redirect_to root_url
            end
        end
        context "when user has micropost" do
            it "redirects to request referrer or root url" do
                delete :destroy, params: { id: micropost.id }, session: valid_session
                expect(response).to redirect_to root_url
            end
        end
    end
end
