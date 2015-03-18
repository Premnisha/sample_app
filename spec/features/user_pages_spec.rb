require 'spec_helper'


feature "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector('h1',    text: 'Sign up') }
    it "should show the correct title" do
      page.source.should have_selector('title', text: 'Sign up', visible: false)
    end
  end

  feature "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it "should show the correct title" do
      page.source.should have_selector('title', text: 'Michael Hartl', visible: false)
    end
  end
end