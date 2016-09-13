FactoryGirl.define do
  factory :effect do
    effectiveness_days { Faker::Number.between(1, 60) }
    supplement
    symptom
  end
end
