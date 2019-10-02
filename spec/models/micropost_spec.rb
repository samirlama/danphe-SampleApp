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

      context "when image size is less than 500kb" do
        it "should validate picture" do
          bmp = BMP::Writer.new(2,2)
          bmp[0,0] = "ff0000"
          bmp[1,0] = "00ff00"
          bmp[0,1] = "0000ff"
          bmp[1,1] = "ffffff" 
          file = bmp.save_as("#{Rails.root}/spec/fixtures/example_generated.jpg")
          img_src = File.join(Rails.root, "spec/fixtures/example_generated.jpg")
          src_file = File.new(img_src)
          subject.picture = src_file
          subject.valid? 
          expect(subject.errors[:picture]).not_to include('should be less than 500 kilobyte')
        end
      end

      context "when image size is more than 500kb" do
        it "should'nt validate picture" do
          bmp = BMP::Writer.new(600,600)
          bmp[0,0] = "ff0000"
          bmp[1,0] = "00ff00"
          bmp[0,1] = "0000ff"
          bmp[1,1] = "ffffff" 
          file = bmp.save_as("#{Rails.root}/spec/fixtures/example_generated.jpg")
          img_src = File.join(Rails.root, "spec/fixtures/example_generated.jpg")
          src_file = File.new(img_src)
          subject.picture = src_file
          subject.valid? 
          expect(subject.errors[:picture]).to include('should be less than 500 kilobyte')
        end
      end


    end

end