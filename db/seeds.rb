# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


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

10.times do
  author = Author.create!(FactoryBot::attributes_for(:author))
  3.times do
    attrs = FactoryBot::attributes_for(:story)
    attrs[:author] = author
    Story.create!(attrs)
  end
end