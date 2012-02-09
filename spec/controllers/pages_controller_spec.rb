require 'spec_helper'

describe PagesController do
  render_views
  before(:each) do
    @base_title = "Micropost Sample | "
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                                   :content => @base_title + "Home")
    end
    describe "signed in user" do
      describe "success"
        before(:each) do
          @user = Factory(:user)
          test_sign_in(@user)
          @mpost = Factory(:mpost, :user=>@user)
        end
        it "should have mpost delete links" do
          get 'home'
          response.should have_selector("a", :href => mpost_path(@mpost),
                                       :content=>"delete")
        end
        describe "failure"
        it "should not have mpost delete links for the wrong user" do
          user = Factory(:user)
          test_sign_in(user)
          other_user = Factory(:user, :email => "grit@sdf.lonestar.org")
          other_user_posts = Factory(:mpost,:user=>other_user)
          response.should_not have_selector("a", :href => mpost_path(other_user_posts),
                                           :content=>'delete')
        end

      end
       
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    it "should have the right title" do
      response.should have_selector("title",
                                   :content => @base_title + "Contact")
    end
  end
  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    it "should have the  right title" do
      get 'about'
      response.should have_selector("title",
                                   :content => @base_title + "About")

    end
  end
  describe "GET 'help '" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    it "should have the right title" do
      response.should have_selector("title",
        :content => @base_title + "Help")
    end
  end

end
