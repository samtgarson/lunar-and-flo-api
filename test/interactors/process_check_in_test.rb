require 'test_helper'

class ProcessCheckInTest < ActiveSupport::TestCase
  setup do
    @symptom = create(:symptom)
    @user = create(:user)
  end

  def successful_context
    ProcessCheckIn.call(user: @user, symptom_ids: [@symptom.id])
  end

  def unsuccessful_context
    ProcessCheckIn.call(user: @user, symptom_ids: [@symptom.id, 'invalid_id'])
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
