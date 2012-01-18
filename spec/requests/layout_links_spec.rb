require 'spec_helper'

describe "LayoutLinks" do
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
                                 :content =>help)
  end
end
