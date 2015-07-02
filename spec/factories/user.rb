FactoryGirl.define do
  factory :user do
    email {Faker::Internet.email}
    name {Faker::Name.name}
    birthday {Faker::Date.backward(3650)}
    password "admin123"
    is_admin false
  end
end
