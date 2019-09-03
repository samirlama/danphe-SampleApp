require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
    let(:user) { create(:user) }
    let(:valid_session) { {user_id: user.id} }
    describe "POST #create" do
            it "follows another user" do
                user1 = User.create(name: "samir", email: "abcd@gmail.com", password: "123456", password_confirmation: "123456")
                expect{
                    post :create, params:{followed_id: user1.id, format: 'js'},session: valid_session
            }.to change(Relationship, :count).by(1)
         end
    end

    describe "DELETE #destroy" do
                it "unfollows another user" do
                    user1 = User.create(name: "samir", email: "abgd@gmail.com", password: "123456", password_confirmation: "123456")
                    user2 = User.create(name: "samir", email: "abdd@gmail.com", password: "123456", password_confirmation: "123456")
                    relationship  = Relationship.create(follower_id: user1.id, followed_id: user2.id) 
             expect{
                delete :destroy, params: {id: relationship.id},session: { user_id: user1.id}
        }.to change(Relationship, :count).by(-1)
        end
    end
end
