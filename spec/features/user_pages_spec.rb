require 'spec_helper'


feature "User pages" do

  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      visit signin_path
      fill_in "Email", with: user.email.upcase
      fill_in "Password", with: user.password
      click_button "Sign in"
      visit users_path
    end

  it { should have_selector('title', text: 'All users',visible: false) }
  it { should have_selector('h1',    text: 'All users') }

  it "should list each user" do
    User.all.each do |user|
      page.should have_selector('li', text: user.name)
    end
  end

  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector('h1',    text: 'Sign up') }
    it "should show the correct title" do
      page.source.should have_selector('title', text: 'Sign up', visible: false)
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit edit_user_path(user)
    end
    describe "with valid information" do
        let(:new_name)  { "New Name" }
        let(:new_email) { "new@example.com" }
        before do
          fill_in "Name",             with: new_name
          fill_in "Email",            with: new_email
          fill_in "Password",         with: user.password
          fill_in "Confirm Password", with: user.password
          click_button "Save changes"
        end

        it { should have_selector('title', text: new_name, visible: false) }
        it { should have_selector('div.alert.alert-success') }
        it { should have_link('Sign out', href: signout_path) }
        specify { user.reload.name.should  == new_name }
        specify { user.reload.email.should == new_email }
    end

    describe "page" do
      it { page.source.should have_selector('h1',text: "Update your profile", visible: false) }
      it { page.source.should have_selector('title', text: "Edit user", visible: false) }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
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
