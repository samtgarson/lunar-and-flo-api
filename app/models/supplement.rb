class Supplement < ApplicationRecord
  has_many :symptoms, through: :effects
  has_many :effects

  validates :name, :description, presence: true
end
