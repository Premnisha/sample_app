require 'rails_helper'
RSpec.describe "AuthenticationPages", type: :request do
  feature "signin" do
    before { visit signin_path }
    describe "with invalid information" do
      before { click_button "Sign in" }
      it "should show the correct title" do
        page.source.should have_selector('title', text: 'Sign in', visible: false)
      end
      it "should show correct alert" do
        page.source.should have_selector('div.alert.alert-error', text: 'Invalid', visible: false)
      end
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    feature "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email", with: user.email.upcase
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
      describe "followed by signout" do
        before { visit signout_path }
          it "should have link to sign in" do
            page.source.should have_link('Sign in', href: signin_path)
          end
      end
        it "should show correct title as name" do
          page.source.should have_selector('title', text: user.name, visible: false)
        end
        it "should show correct user profile" do
          page.source.should have_link('Profile', href: user_path(user), visible: false)
        end
        it "should show sign out" do
          page.source.should have_link('Sign out', href: signout_path)
        end
        it { should_not have_link('Sign in', href: signin_path) }
    end
  end
end