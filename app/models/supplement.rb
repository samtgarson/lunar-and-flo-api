class Supplement < ApplicationRecord
  has_many :symptoms, through: :supplement_symptom
  has_many :supplement_symptom

  validates :name, :description, presence: true
end
