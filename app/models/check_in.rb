class CheckIn < ApplicationRecord
  belongs_to :symptom
  belongs_to :user

  validates :user, :symptom, presence: true
end
