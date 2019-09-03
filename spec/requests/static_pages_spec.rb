require 'rails_helper'
require 'spec_helper'

RSpec.describe "StaticPages", type: :request do
  subject { page }
   describe "About page" do
    before { visit '/about' }
      it {should have_content("About")}
      it { should have_title("About")}
  end
end
