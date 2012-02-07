require 'spec_helper'
describe Mpost do
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :content => "value for content",
    }
  end

  it "should create a new instance given valid attributes" do
    @user.mposts.create!(@attr)
  end
  describe "user associations" do
    before(:each) do
      @mpost = @user.mposts.create(@attr)
    end
    it "should have a user atrtibute" do
      @mpost.should respond_to(:user)
    end
    it "should have the right associated user" do
      @mpost.user_id.should == @user.id
      @mpost.user.should.should == @user
    end
  end
  describe "validations" do
    it "should require a user id" do
      Mpost.new(@attr).should_not be_valid
    end
    it "should require non blank content" do
      @user.mposts.build(:content => "   ").should_not be_valid
    end
    it "should reject long content" do
      @user.mposts.build(:content => "a" * 141).should_not be_valid
    end
  end
end
