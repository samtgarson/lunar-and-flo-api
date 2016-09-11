class Pack < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :effects

  validates :user, presence: true
end
