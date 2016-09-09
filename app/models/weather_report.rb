class WeatherReport < ApplicationRecord
  has_many :check_ins

  acts_as_mappable
end
