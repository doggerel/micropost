require 'spec_helper'

describe "Mposts" do
  before(:each) do
    user = Factory(:user)
    visit signin_path
    fill_in :email, :with => user.email 
    fill_in :password, :with => user.password
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
      it "should make a new micropost" do
        content = "Lorem ipsum sit amet"
        lambda do
          visit root_path
          fill_in :mpost_content, :with => content
          click_button
          response.should have_selector("span.content", 
                                        :content=>content)
        end.should change(Mpost, :count).by(1)
      end
    end
  end
end
