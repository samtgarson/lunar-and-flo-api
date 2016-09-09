FactoryGirl.define do
  factory :symptom_group do
    name { Faker::Hacker.abbreviation }
  end
end
