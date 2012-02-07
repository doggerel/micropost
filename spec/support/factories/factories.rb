FactoryGirl.define do 
  factory :user do
    name  "Fred Hudson"
    email   "remotezen@bell.net"
    password  "password"
    password_confirmation  "password"
  end
  factory :mpost do
    content "this is a long micropost in order to test this factory"
    association :user

  end
end
