require 'spec_helper'
describe UsersController do
  render_views
  before(:each) do
    @base_title = "Micropost Sample | "
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  it "should have the right title" do
    get 'new'
    response.should have_selector("title",
            :content=>@base_title + "Sign up")
  end
  it "should have a name field" do
    get :new
    response.should have_selector("input[name='user[name]'][type='text']")
  end
  it "should have a email field" do
    get :new
    response.should have_selector("input[name='user[email]'][type='text']")
  end
  
 end
  describe "Get 'show'" do
    before(:each) do
      @user = Factory(:user)
    end
    it "should be successful" do
      get :show, :id => @user
    end
    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user

    end
  end
  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr ={:name=>"",
                :email => "",
                :password=>"",
                :password_confirmation=>""}
        end
      it "should not create a user" do
        lambda do
          post :create, :user=>@attr
        end.should_not change(User,:count)
      end
      it "should have the right title" do
        post :create, :user =>@attr
        response.should have_selector("title",
        :content=>@base_title + "Sign up")
      end
      it "should render the 'new' page" do
        post :create, :user=>@attr
        response.should render_template('new')

      end
    end
    describe "success" do
     before(:each) do
       @attr ={
         :name =>"name",
         :email =>"name@name.com",
         :password => "password",
         :password_confirmation=>"password",
       }
     end
     it "should create user" do
       lambda do
         post :create, :user => @attr
       end.should change(User, :count).by(1)
     end
     it "should redirect to the user show page" do
       post :create, :user=>@attr
       response.should redirect_to(user_path(assigns(:user)))
     end
     it "should have a welcome message" do
       post :create, :user => @attr
       flash[:success].should =~/Welcome to the micropost app/i
     end
    end
  end
end
