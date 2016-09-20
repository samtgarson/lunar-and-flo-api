class Symptom < ApplicationRecord
  belongs_to :symptom_group
  has_many :check_in_symptoms, dependent: :destroy
  has_many :supplements, through: :effects
  has_many :effects

  validates :name, :description, :symptom_group, presence: true

  class << self
    def for(user, limit: 3)
      joins(check_in_symptoms: :check_in)
        .where(check_in_symptoms: { check_ins: { user_id: user.id } })
        .group('symptoms.id')
        .order('count(check_in_symptoms.check_in_id) DESC')
        .limit(limit)
    end
  end
end
