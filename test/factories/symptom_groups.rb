FactoryGirl.define do
  factory :symptom_group do
    name { Faker::Hacker.abbreviation }
    physical true
    points { [-1, 1].sample }
    icon { SymptomGroup.icons.keys.sample }
  end
end
