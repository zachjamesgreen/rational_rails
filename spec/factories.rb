FactoryBot.define do
  factory :author do
    name   { Faker::Name.name }
    rating { rand(6) }
    admin  { rand(2) == 0 ? true : false }
  end

  factory :story do
    name { Faker::Lorem.sentence }
    likes { rand(100) }
    published { rand(2) == 0 ? true : false }
  end
end