require 'spec_helper'

describe "Users" do
  describe "signup" do
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit  signup_path
          #puts response.body
          fill_in :name,         :with=>""
          fill_in :email,        :with=>""
          fill_in :password,     :with=>""
          fill_in "Confirmation", :with=>""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count).by(1) 
      end
    end
    describe "success" do
      before(:each) do
        @user = Factory(:user)
      end
      it "should make a new user" do
      lambda do
        integration_sign_in(@user)
        response.should render_template('users/show')
      end.should change(User,:count).by(1)
    end
  end
end
  describe "sign in/out" do
    describe "failure" do
      before(:each) do
        @user = Factory(:user)
      end
      it "should not sign a user in" do
        integration_sign_in(@user)
        response.should have_selector("div.flash.error",
                                     :content=>"Invalid")
      end
    end
    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        integration_sign_in(user)
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end
end
