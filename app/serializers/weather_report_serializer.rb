class WeatherReportSerializer < ActiveModel::Serializer
  attributes :id, :icon, :cloud_cover, :temperature, :precip_probability, :precip_type, :moon_phase
end
