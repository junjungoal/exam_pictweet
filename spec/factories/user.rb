FactoryGirl.define do
  factory :user do
    nickname {Faker::Internet.user_name(1..6)}
    password {Faker::Internet.password(8)}
    email {Faker::Internet.email}
  end
end
