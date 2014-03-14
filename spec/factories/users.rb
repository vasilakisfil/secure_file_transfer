FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    name "John Doe"
    sequence(:email) { |n| "username#{n}@example.com" }
  end
end

