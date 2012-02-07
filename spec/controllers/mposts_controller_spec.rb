require 'spec_helper'

describe MpostsController do
  render_views
  it "should deny access to  'create'" do
    post :create
    response.should redirect_to(signin_path)
  end
  it "should deny access to 'destroy'" do
    delete :destroy, :id=>1 
    response.should redirect_to(signin_path)
  end
  describe "POST 'create'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    describe "failure" do
      before(:each) do
        @attr = {:content =>""}
      end
      it "should not create a mpost" do
        lambda do
          post :create, :mpost =>@attr
        end.should_not change(Mpost, :count)
       end
      it "should render the home page" do
        post :create, :mpost => @attr
        response.should render_template('pages/home')
      end
    end
    describe "success" do
      before(:each) do
        @attr = {:content => "Lorem ipsum"}
      end
      it "should create a mpost" do
        lambda do
          post :create, :mpost => @attr
        end.should change(Mpost, :count).by(1)
      end
      it "should redirect to the home page" do
        post :create, :mpost => @attr
        response.should redirect_to(root_path)
      end
    it "should have a flash message" do
      post :create, :mpost => @attr
      flash[:success].should =~ /mpost created/i
    end
  end
  end
end
