FactoryGirl.define do
  factory :weather_report do
    icon { %w(clear-day clear-night rain snow sleet wind fog cloudy partly-cloudy-day partly-cloudy-night).sample }
    cloud_cover { Faker::Number.between(0, 100) / 100 }
    moon_phase { Faker::Number.between(0, 100) / 100 }
    temperature { Faker::Number.between(-10, 40) }
    precip_probability { Faker::Number.between(0, 100) / 100 }
    precip_type { %w(rain snow sleet).sample }
    lat { Faker::Number.decimal([1, 2].sample, 2) }
    lng { Faker::Number.decimal([1, 2].sample, 2) }
  end
end
