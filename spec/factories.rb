require 'faker'
include Faker

FactoryBot.define do

  factory :restaurant do
    name { Faker::Name.name }
    cuisine_id 1
    address 'Tel Aviv'
    delivery_time { Faker::Number.number(3) }
  end

  factory :cuisine do
    id 1
    name 'Cuisine_default'
  end
end