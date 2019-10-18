require 'rails_helper'
require 'tempfile'

RSpec.describe Micropost, type: :model do
 
  let(:user) { create(:user) }
  describe "Assocciation" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validation" do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_most(140)}
    
    context "when image size is more than 500kb" do
      it "should validate picture" do
        allow(subject.picture).to receive(:size).and_return(501.kilobytes)
        expect(subject.picture.size).to be > 500.kilobytes
        subject.valid?
        expect(subject.errors[:picture]).to include('should be less than 500 kilobyte')
      end
    end

    context "when image size is less than 500kb" do
      it "should validate picture" do
        file_path = generate_file_path #it is a method 
        img_src = File.join(file_path)
        src_file = File.new(img_src)
        subject.picture = src_file
        allow(subject.picture).to receive(:size).and_return(400.kilobytes)
        expect(subject.picture.size).to be  < 500.kilobytes
        subject.valid?
        expect(subject.errors[:picture]).not_to include("should be less than 500 kilobyte")
      end
    end

  end
end