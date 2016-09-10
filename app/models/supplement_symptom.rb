class SupplementSymptom < ApplicationRecord
  belongs_to :symptom
  belongs_to :supplement

  validates :symptom, :supplement, presence: true
end
