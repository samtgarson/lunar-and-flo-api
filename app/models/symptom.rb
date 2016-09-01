class Symptom < ApplicationRecord
  belongs_to :symptom_group
  has_many :check_ins

  validates :name, :description, :symptom_group, presence: true

  def self.for (user, limit: 3)
    select('symptoms.*, count(check_ins.id) AS check_ins_count')
      .joins(:check_ins)
      .where(check_ins: { user_id: user.id })
      .group('symptoms.id')
      .order('check_ins_count DESC')
      .limit(limit)
  end
end
