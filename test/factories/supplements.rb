FactoryGirl.define do
  factory :supplement do
    name { Faker::StarWars.planet }
    description { Faker::StarWars.quote }
  end
end
