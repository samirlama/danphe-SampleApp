require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) {create(:user1)}
  let (:user2) { create(:user2) }
  subject (:relationship ) { Relationship.all }
  describe "validations" do
    context "when user is valid" do
      let(:user) { build(:user) }
        it "is a valid with valid attributes" do
          expect(user).to be_valid
        end
    end

    context "when user is invalid" do
      let(:user) { build(:invalid_user) } 
      it "doesnt pass validationns" do
        expect(user).not_to be_valid
      end
    end
  end

  
    describe "Associations" do
      it { should have_many(:microposts) }
      it { should have_many(:active_relationships) }
      it { should have_many(:passive_relationships) }
      it { should have_many(:followers) }
      it { should have_many(:following) }
    end

    describe '#follow' do   
      it "creates a follower" do
        result = user1.follow(user2)
        expect(result.followed_id).to eq(user2.id)
      end
    end

    describe '#feed' do
      let(:user) { create(:user1) }
      it "returns micropost" do
          micropost = user.microposts.create(content: "eyjashdjkashdasjbdakshdkajshdliashdiasudhabds,adjkaksbd asjd asjbdasmdhjas")
          result = user.feed
          expect(result).to eq([micropost])
      end 
    end

    # describe '#unfollow' do
    #   let(:user1) {create(:user1)}
    #   let (:user2) { create(:user2) }
    #   it "unfollowes user" do
    #       user1.follow(user2)
    #       result = user1.unfollow(user2)
    #       expect(result).to be_empty
    #   end
    # endx
    
    describe "#activate" do
      it "updates user activated column to true" do
        result = user1.activate
        expect(result).to eq(true)
      end
    end

    describe "#following" do
      before do 
        user1.follow(user2)
      end
      it "follows other user" do
          result = user1.following?(user2)
          expect(relationship).to eq([result])
      end
    end
    
    describe "#forget" do
    let!(:user) { create(:user, remember_digest: '123123123123ghfy123123') }
      it "updates remember digests to nil" do
           result = user.forget
           expect(user.remember_digest).to be_nil
      end
    end
end
