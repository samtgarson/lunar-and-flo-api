class Pack < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :effects
  has_many :symptoms, through: :effects

  validates :user, presence: true
  validates :effects, length: { minimum: 3, maximum: 3 }
end
