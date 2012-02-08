require 'spec_helper'

describe "LayoutLinks" do
  before(:each) do
    @base_title = "Micropost Sample | "
  end
  it "should have a home page  at '/'" do
    get '/'
    response.should have_selector('title', :content =>"Home")
  end
  it "should have a contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title',
                                  :content =>"Contact"
    )
  end
  it "should have a help page at '/help'" do
    get '/help'
    response.should have_selector('title',
                                 :content =>"Help")
  end
  it "should have an about page at '/about'" do
    get '/about'
    response.should have_selector('title',
      :content =>"About")
  end
  it "should have a signup page at 'signup'" do
    get '/signup'
    response.should have_selector('title',
            :content=> "Sign up")
  end
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    response.should have_selector("title", :content=>@base_title + "About")
    click_link "Contact"
    response.should have_selector("title", :content=>@base_title + "Contact")
    click_link "Home"
    response.should have_selector("title", :content=>@base_title + "Home")
    click_link "Sign up now!"
    response.should have_selector("title", :content=>@base_title + "Sign up")

  end
  describe "when not signed in" do
    it "should have a signin link" do
      #request.env['HTTPS'] = 'on'
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                   :content => "Sign in")
    end
  end
  describe "when signed in" do
    before(:each) do
      @user = Factory(:user)
      integration_sign_in(@user)
    end
    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href=>signout_path,
                                   :content => "Sign out")
    end
    it "should have a profile link" do
      visit root_path
      response.should have_selector("a",:href => user_path(@user),
                                   :content => "Profile")

    end
  end
end
