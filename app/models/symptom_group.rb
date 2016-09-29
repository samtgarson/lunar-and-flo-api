class SymptomGroup < ApplicationRecord
  has_many :symptoms

  validates :name, presence: true

  enum icon: %i(happy sad angry confused thoughtful caring)
end
