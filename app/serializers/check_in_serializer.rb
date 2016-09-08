class CheckInSerializer < ActiveModel::Serializer
  attributes :id, :lat, :lng

  has_many :symptoms
  belongs_to :weather_report
end
