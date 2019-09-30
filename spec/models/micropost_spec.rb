require 'rails_helper'

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
        it "should render error messages" do
          kit = IMGKit.new('http://google.com', options=  { 'width': 10000, 'height': 10000 })
          img = kit.to_img
          file = kit.to_file("#{Rails.root}/spec/fixtures/file.jpg")
          image_src  = File.join(Rails.root, "spec/fixtures/file.jpg")
          src_file = File.new(image_src)
          subject.picture = src_file
          subject.valid? 
          expect(subject.errors[:picture]).to include('should be less than 500 kilobyte')
        end
      end

      context "when image size is less than 500kb" do
        it "should validate picture" do
          kit = IMGKit.new('http://google.com')
          img = kit.to_img
          file = kit.to_file("#{Rails.root}/spec/fixtures/file.jpg")
          image_src  = File.join(Rails.root, "spec/fixtures/file.jpg")
          src_file = File.new(image_src)
          subject.picture = src_file
          subject.valid? 
          expect(subject.errors[:picture]).not_to include('should be less than 500 kilobyte')
        end
      end
    end

end