# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username)     {|n| "username#{n}"}
    sequence(:email)        {|n| "email-#{n}@example.com"}
    password                "password"
    password_confirmation   "password"
  end
end
