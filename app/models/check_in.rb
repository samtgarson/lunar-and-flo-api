class CheckIn < ApplicationRecord
  belongs_to :user
  belongs_to :weather_report, optional: true

  has_many :check_in_symptoms, dependent: :destroy
  has_many :symptoms, through: :check_in_symptoms

  validates :user, presence: true

  acts_as_mappable

  scope :on_day, -> (time) { where("date_trunc('day', created_at) = ?", time.to_date) }

  def location?
    lat.present? && lng.present?
  end

  def score
    symptoms.joins(:symptom_group).sum('points')
  end
end
