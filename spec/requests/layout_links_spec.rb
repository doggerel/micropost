require 'spec_helper'

describe "LayoutLinks" do
  it "should have a home page '/'" do
    get '/'
    response.should have_selector('title', :content =>"Home")
  end
end
