require 'test_helper'

class CreateCheckInsTest < ActiveSupport::TestCase
  setup do
    @symptom = create(:symptom)
    @user = create(:user)
  end

  def successful_context
    @successful_context ||= CreateCheckIns.call(user_id: @user.id, symptom_ids: [@symptom.id], lat: 1.0, lng: 1.0)
  end

  def unsuccessful_context
    @unsuccessful_context ||= CreateCheckIns.call(user_id: @user.id, symptom_ids: [@symptom.id, 'invalid_id'], lat: 1.0, lng: 1.0)
  end

  test 'it succeeds if symptoms are valid' do
    assert successful_context.success?
  end

  test 'it provides check ins if symptoms are valid' do
    assert_equal successful_context.check_ins.size, 1
  end

  test 'it fails if symptoms are invalid' do
    assert unsuccessful_context.failure?
  end

  test 'it provides invalid symptom ids if symptoms are invalid' do
    assert_equal unsuccessful_context.failed_symptoms, ['invalid_id']
  end
end
