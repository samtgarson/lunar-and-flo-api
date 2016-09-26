class Pack < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :effects
  has_many :symptoms, through: :effects

  validates :user, presence: true
end
