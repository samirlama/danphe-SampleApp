require 'rails_helper'

RSpec.describe User, type: :model do
  # it {should validate_presence_of :name}
  # it {should validate_presence_of :email}
  # it {should validate_presence_of :password}
  # it {should validate_length_of(:password).is_at_least(6)}
  # it {should validate_length_of(:name).is_at_most(50) }
  # it {should validate_length_of(:email).is_at_most(255)}
  let(:user) { build(:invalid_user) }
  it "is invalid without an email" do
   
    expect(user).not_to be_valid
  end
end
