class WeatherReport < ApplicationRecord
  has_many :check_ins
  has_one :location, as: :locatable

  acts_as_mappable through: :location
end
