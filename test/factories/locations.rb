FactoryGirl.define do
  factory :location do
    lat { Faker::Number.decimal([1, 2].sample, 2) }
    lng { Faker::Number.decimal([1, 2].sample, 2) }
  end
end
