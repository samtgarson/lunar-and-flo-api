class AttachCheckInMetaData
  include Interactor

  context_requires check_in: CheckIn

  delegate :check_in, to: :context

  def call
    return unless check_in.location?
    check_in.update_attributes(weather_report: weather_report) if weather_report.valid?
  end

  private

    def weather_report
      @weather_report ||= existing_weather_report || new_weather_report
    end

    def existing_weather_report
      WeatherReport.within(2.5, origin: check_in).first
    end

    def new_weather_report
      WeatherReport.create weather_data.merge(moon_phase: moon_phase, lat: check_in.lat, lng: check_in.lng)
    end

    def weather_data
      forecast
        .currently
        .to_snake_keys
        .slice(*WeatherReport.attribute_names.map(&:to_sym))
    end

    def moon_phase
      forecast.daily.data.first.moonPhase
    end

    def forecast
      @forecast ||= ForecastIO.forecast(check_in.lat, check_in.lng, time: check_in.created_at.to_i)
    end
end
