require 'spec_helper'


feature "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }
    
    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
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