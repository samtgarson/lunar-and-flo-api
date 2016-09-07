require 'test_helper'

class CreateNewCheckInsTest < ActiveSupport::TestCase
  setup do
    @symptom = create(:symptom)
    @user = create(:user)
  end

  def successful_context
    @successful_context ||= CreateNewCheckIns.call(user_id: @user.id, symptom_ids: [@symptom.id])
  end

  def unsuccessful_context
    @unsuccessful_context ||= CreateNewCheckIns.call(user_id: @user.id, symptom_ids: [@symptom.id, 'invalid_id'])
  end

  test 'it succeeds if symptoms are valid' do
    assert successful_context.success?
  end

  test 'it provides check ins if symptoms are valid' do
    assert_equal successful_context.check_in.check_in_symptoms.size, 1
  end

  test 'it fails if symptoms are invalid' do
    assert unsuccessful_context.failure?
  end

  test 'it provides invalid symptom ids if symptoms are invalid' do
    assert_equal unsuccessful_context.failed_symptoms, ['invalid_id']
  end
end
