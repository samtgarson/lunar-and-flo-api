FactoryGirl.define do
  factory :symptom do
    name { Faker::StarWars.planet }
    description { Faker::StarWars.quote }
    symptom_group
  end
end
