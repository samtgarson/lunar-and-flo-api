class SymptomGroup < ApplicationRecord
  has_many :symptoms

  validates :name, presence: true
end
