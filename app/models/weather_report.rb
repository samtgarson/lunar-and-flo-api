class WeatherReport < ApplicationRecord
  has_many :check_ins
  has_one :location, as: :locatable

  validates :check_ins, presence: true

  acts_as_mappable through: :location
end
