class CheckIn < ApplicationRecord
  belongs_to :user
  belongs_to :weather_report, optional: true

  has_many :check_in_symptoms, dependent: :destroy
  has_many :symptoms, through: :check_in_symptoms

  validates :user, presence: true

  acts_as_mappable

  scope :on_day, -> (time) { where("date_trunc('day', created_at) = ?", time.to_date) }

  PERIOD_SCORE = -2.freeze

  def location?
    lat.present? && lng.present?
  end

  def score
    symptoms.joins(:symptom_group).sum('points') + (period? ? PERIOD_SCORE : 0)
  end

  def icon
    return unless symptoms.any?
    max = icon_counts.values.max
    SymptomGroup.icons.keys[icon_counts.select { |_k, v| v == max }.keys.sample]
  end

  private

    def icon_counts
      @icon_counts ||= symptoms.joins(:symptom_group).group(:icon).order('count_icon desc').count(:icon)
    end
end
