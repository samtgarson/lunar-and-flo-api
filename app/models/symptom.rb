class Symptom < ApplicationRecord
  belongs_to :symptom_group

  validates :name, :description, :symptom_group, presence: true
end
