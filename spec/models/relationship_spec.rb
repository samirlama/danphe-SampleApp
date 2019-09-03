require 'rails_helper'

RSpec.describe Relationship, type: :model do
    describe "Associations" do
      it {is_expected.to belong_to(:follower)}
      it {is_expected.to belong_to(:followed)}
    end

    describe "Validations" do
      it { is_expected.to validate_presence_of(:follower_id) }
      it { is_expected.to validate_presence_of(:followed_id)}
    end
end
