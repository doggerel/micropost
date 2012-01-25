FactoryGirl.define do 
  factory :user do
    name  "Fred Hudson"
    email   "remotezen@bell.net"
    password  "password"
    password_confirmation  "password"
  end
end
