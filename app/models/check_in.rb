class CheckIn < ApplicationRecord
  belongs_to :symptom
  belongs_to :user

  has_one :location, as: :locatable

  validates :user, :symptom, presence: true

  acts_as_mappable through: :location
end
