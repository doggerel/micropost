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
      it "should make a new user" do
      lambda do
        visit signup_path
        fill_in :name, :with =>"Fred hudson"
        fill_in :email, :with => "grit@sdf.lonestar.org"   
        fill_in  :password, :with => "password"
        fill_in "Confirmation", :with =>"password"
        click_button
        response.should render_template('users/show')
      end.should change(User,:count).by(1)
    end
  end
end
end
