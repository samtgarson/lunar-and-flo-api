class Effect < ApplicationRecord
  belongs_to :symptom
  belongs_to :supplement
  has_and_belongs_to_many :packs

  validates :symptom, :supplement, presence: true
end
