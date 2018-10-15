FactoryBot.define do

  factory :restaurant do
    name 'Rest_default'
    cuisine_id 1
    address 'Tel Aviv'
    delivery_time 50
  end

  factory :cuisine do
    id 1
    name 'Cuisine_default'
  end
end