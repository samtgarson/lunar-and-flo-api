FactoryGirl.define do
  factory :symptom do
    transient do
      supplement_count 0
    end

    name { Faker::StarWars.planet }
    description { Faker::StarWars.quote }
    symptom_group
    supplements { build_list :supplement, supplement_count }
  end
end
