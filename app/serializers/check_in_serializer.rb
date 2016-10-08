class CheckInSerializer < ActiveModel::Serializer
  attributes :id, :lat, :lng, :score, :icon, :period

  has_many :symptoms
  belongs_to :weather_report
end
