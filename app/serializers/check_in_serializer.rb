class CheckInSerializer < ActiveModel::Serializer
  attributes :id, :lat, :lng, :score, :icon

  has_many :symptoms
  belongs_to :weather_report
end
