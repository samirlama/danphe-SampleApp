require 'rails_helper'

RSpec.describe Relationship, type: :model do
    describe "Associations" do
      it {should belong_to(:follower)}
      it {should belong_to(:followed)}
    end

    describe "Validations" do
      it {should validate_presence_of(:follower_id)}
      it { should validate_presence_of(:followed_id)}
    end
end
