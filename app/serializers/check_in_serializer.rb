class CheckInSerializer < ActiveModel::Serializer
  attributes :id, :lat, :lng, :score

  has_many :symptoms
  belongs_to :weather_report
end
