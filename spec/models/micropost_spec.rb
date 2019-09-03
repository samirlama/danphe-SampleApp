require 'rails_helper'

RSpec.describe Micropost, type: :model do
    describe "Assocciation" do
      it { is_expected.to belong_to(:user) }
    end

    describe "validation" do
      it { is_expected.to validate_presence_of(:user_id) }
      it { is_expected.to validate_presence_of(:content) }
      it { is_expected.to validate_length_of(:content).is_at_most(140)}
    end
end