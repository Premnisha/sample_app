require 'spec_helper'

feature "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h1',    text: 'Sample App') }
    it "should show the correct title" do
      page.source.should have_selector('title', text: '', visible: false)
    end
    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_selector('h1',    text: 'Help') }
    it "should show the correct title" do
      page.source.should have_selector('title', text: 'Help', visible: false)
    end
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('h1',    text: 'About Us') }
    it "should show the correct title" do
      page.source.should have_selector('title', text: 'About Us', visible: false)
    end
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_selector('h1',    text: 'Contact') }
    it "should show the correct title" do
      page.source.should have_selector('title', text: 'Contact', visible: false)
    end
  end
end