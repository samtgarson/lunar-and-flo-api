class CheckIn < ApplicationRecord
  belongs_to :user

  has_one :location, as: :locatable
  has_one :weather_report

  has_many :check_in_symptoms, dependent: :destroy
  has_many :symptoms, through: :check_in_symptoms

  validates :user, presence: true

  acts_as_mappable through: :location
end
