require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) {create(:user1)}
  let (:user2) { create(:user2) }
  let (:relationship ) { Relationship.all }
  describe "validations" do
    it {is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_length_of(:name).is_at_most(50)} 
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password)}
    it { is_expected.to validate_length_of(:email).is_at_most(255)}
    it { is_expected.to validate_length_of(:password).is_at_least(6)}
  end

  
  describe "Associations" do
    it { is_expected.to have_many(:microposts) }
    it { is_expected.to have_many(:active_relationships) }
    it { is_expected.to have_many(:passive_relationships) }
    it { is_expected.to have_many(:followers) }
    it { is_expected.to have_many(:following) }
  end

    describe '#follow' do   
      it "creates a follower" do
        result = user1.follow(user2)
        expect(relationship).to eq([result])
      end
    end

    describe '#feed' do
      it "returns micropost" do
          micropost = user1.microposts.create(content: "eyjashdjkashdasjbdakshdkajshdliashdiasudhabds,adjkaksbd asjd asjbdasmdhjas")
          result = user1.feed
          expect(result).to eq([micropost])
      end 
    end

    describe '#unfollow' do
      before do
        user1.follow(user2)
      end
      it "unfollows user" do
          result = user1.unfollow(user2)
          expect(relationship.count).to  eq(0)
      end
    end
    
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
          expect(result).to eq(true)
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
