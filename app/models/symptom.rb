class Symptom < ApplicationRecord
  belongs_to :symptom_group
  has_many :check_in_symptoms, dependent: :destroy

  validates :name, :description, :symptom_group, presence: true

  def self.for(user, limit: 3)
    joins(check_in_symptoms: :check_in)
      .select('symptoms.*, count(check_in_symptoms.check_in_id) AS check_ins_count')
      .where(check_in_symptoms: { check_ins: { user_id: user.id } })
      .group('symptoms.id')
      .order('check_ins_count DESC')
      .limit(limit)
  end
end
