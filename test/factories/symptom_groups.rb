FactoryGirl.define do
  factory :symptom_group do
    name { Faker::Hacker.abbreviation }
    physical true
  end
end
