require 'test_helper'

class AttachCheckInMetaDataTest < ActiveSupport::TestCase
  setup do
    @check_in = create :check_in, :with_location, user: create(:user)
  end

  def successful_context
    @successful_context ||= AttachCheckInMetaData.call(check_in: @check_in)
  end

  def forecast_data
    data = JSON.parse(forecast_json)
    data['currently'].to_snake_keys.merge(moon_phase: data['daily']['data'].first['moonPhase'])
  end

  def testable_attributes
    %i(cloud_cover temperature precip_probability moon_phase)
  end

  test 'should succeed with a valid location' do
    assert successful_context.success?
  end

  test 'should attach a new weather report' do
    context_report = successful_context.check_in.weather_report.attributes.symbolize_keys
    testable_attributes.each do |attr|
      assert_equal forecast_data[attr], context_report[attr]
    end
  end

  test 'should attach an existing weather report' do
    existing_weather_report = create :weather_report, lat: @check_in.lat, lng: @check_in.lng
    assert_equal successful_context.check_in.weather_report, existing_weather_report
  end

  test 'should succeed without location' do
    @check_in.update_attributes(lat: nil, lng: nil)

    assert successful_context.success?
  end
end
