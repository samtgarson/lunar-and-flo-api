class Symptom < ApplicationRecord
  belongs_to :symptom_group
  has_many :check_ins

  validates :name, :description, :symptom_group, presence: true
end
