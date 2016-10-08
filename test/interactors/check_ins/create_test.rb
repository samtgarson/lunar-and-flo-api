require 'test_helper'

class CheckIns::CreateTest < ActiveSupport::TestCase
  setup do
    @symptom = create(:symptom)
    @user = create(:user)
  end

  def successful_context
    @successful_context ||= CheckIns::Create.call(user: @user, symptom_ids: [@symptom.id], lat: 1.0, lng: 1.0, period: true)
  end

  def unsuccessful_context
    @unsuccessful_context ||= CheckIns::Create.call(user: @user, symptom_ids: [@symptom.id, 'invalid_id'])
  end

  test 'it succeeds if symptoms are valid' do
    assert successful_context.success?
  end

  test 'it provides check ins if symptoms are valid' do
    assert successful_context.check_in
    assert_equal successful_context.lat, 1.0
    assert_equal successful_context.lng, 1.0
    assert_equal successful_context.period, true
  end

  test 'it fails if symptoms are invalid' do
    assert unsuccessful_context.failure?
  end

  test 'it provides invalid symptom ids if symptoms are invalid' do
    assert_equal unsuccessful_context.errors[:failed_symptoms], ['invalid_id']
  end
end
