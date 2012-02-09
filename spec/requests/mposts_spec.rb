require 'spec_helper'

describe "Mposts" do
  before(:each) do
    @user = Factory(:user)
    visit signin_path
    fill_in :email, :with => @user.email 
    fill_in :password, :with => @user.password
    click_button
  end
  describe "creation" do
    describe "failure" do
      it "should not make a new micropost" do
        lambda do
          visit root_path
          fill_in :mpost_content, :with =>""
          click_button 
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Mpost, :count)
      end
    end
    describe "success" do
      before(:each) do
        @content = "Lorem ipsum sit amet"
      end
      
      it "should make a new micropost" do
        lambda do
          visit root_path
          fill_in :mpost_content, :with => @content
          click_button
        response.should have_selector("li", 
                                    :content=> "currently has #{@user.mposts.count} post")
          response.should have_selector("span.content", 
                                        :content=>@content)
        end.should change(Mpost, :count).by(1)
      end
      it "should have a singular side bar mpost count" do
        lambda do
          integration_make_posts(@content)
        end.should change(Mpost, :count).by(1)
        response.should have_selector("li", 
                                    :content=> "currently has #{@user.mposts.count} post")
      end
      it "should have a plural side bar mpost count" do
        lambda do
          integration_make_posts(@content)
          integration_make_posts(@content)
        end.should change(Mpost, :count).by(2)
        response.should have_selector("li", 
                                    :content=> "currently has #{@user.mposts.count} posts")
      end
    end
  end
end
