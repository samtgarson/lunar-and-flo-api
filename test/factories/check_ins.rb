FactoryGirl.define do
  factory :check_in do
    trait :with_location do
      lat { Faker::Number.decimal([1, 2].sample, 2) }
      lng { Faker::Number.decimal([1, 2].sample, 2) }
    end
  end
end
